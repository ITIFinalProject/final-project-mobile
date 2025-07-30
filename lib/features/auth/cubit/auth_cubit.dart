import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventify_app/features/auth/cubit/auth_state.dart';
import 'package:eventify_app/features/auth/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;
import 'package:uuid/uuid.dart';


class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthCubit() : super(AuthInitial());

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('userId',result.user!.uid);
      final doc =
      await FirebaseFirestore.instance
          .collection('users')
          .doc(result.user!.uid)
          .get();

      if (!doc.exists) {
        emit(AuthFailure("User data not found in Firestore"));
        return;
      }

      UserModel user = UserModel.fromFireStore(doc.data()!);

      emit(AuthSuccess(user));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? "Unknown error"));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signUp(String email,
      String password,
      String name,
      String phone,
      String address,) async {
    emit(AuthLoading());
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('userId', result.user!.uid);
      UserModel user = UserModel(
        name: name,
        email: email,
        phone: phone,
        address: address,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(result.user!.uid)
          .set(user.toFireStore());
      emit(AuthSuccess(user));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? "Unknown error"));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    try {
      await _auth.signOut();
      await GoogleSignIn().signOut();
      emit(AuthLoggedOut());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> resetPassword(String email) async {
    emit(AuthLoading());
    try {
      await _auth.sendPasswordResetEmail(email: email);
      emit(
        ResetPasswordSuccess("Password reset link has been sent to your email"),
      );
    } on FirebaseAuthException catch (e) {
      emit(
        AuthFailure(
          e.message ?? 'An error occurred while resetting the password.',
        ),
      );
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  // void checkUserLoggedIn() async {
  //   await Future.delayed(Duration(seconds: 2));
  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     final doc =
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(user.uid)
  //         .get();
  //     UserModel currentUser = UserModel.fromFireStore(doc.data()!);
  //     emit(AuthSuccess(currentUser));
  //   } else {
  //     emit(AuthLoggedOut());
  //   }
  // }
  void checkUserLoggedIn() async {
    await Future.delayed(const Duration(seconds: 2));

    final currentUser = FirebaseAuth.instance.currentUser;

    // الحصول على userId المحفوظ مسبقًا
    final prefs = await SharedPreferences.getInstance();
    final localUserId = prefs.getString('userId');

    if (currentUser != null && currentUser.uid == localUserId) {
      try {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();

        if (doc.exists) {
          UserModel userModel = UserModel.fromFireStore(doc.data()!);
          emit(AuthSuccess(userModel));
        } else {
          await FirebaseAuth.instance.signOut();
          emit(AuthLoggedOut());
        }
      } catch (e) {
        await FirebaseAuth.instance.signOut();
        emit(AuthLoggedOut());
      }
    } else {
      signOut();
      emit(AuthLoggedOut());
    }
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        emit(AuthFailure("Google sign-in aborted."));
        return;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final result = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      final user = result.user;

      final userModel = UserModel(
        name: user?.displayName ?? '',
        email: user?.email ?? '',
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .set(userModel.toFireStore(), SetOptions(merge: true));

      emit(AuthSuccess(userModel));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signInWithFacebook() async {
    emit(AuthLoading());
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final accessToken = result.accessToken;

        final facebookAuthCredential = FacebookAuthProvider.credential(
          accessToken!.tokenString,
        );

        final userCredential = await FirebaseAuth.instance.signInWithCredential(
          facebookAuthCredential,
        );

        final user = userCredential.user;

        final userModel = UserModel(
          name: user?.displayName ?? '',
          email: user?.email ?? '',
        );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .set(userModel.toFireStore(), SetOptions(merge: true));

        emit(AuthSuccess(userModel));
      } else {
        emit(AuthFailure(result.message ?? "Facebook sign-in failed."));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> updateUserProfile({
    required String name,
    required String phone,
    required String address,
    String? newPassword,
    File? imageFile,
  }) async {
    emit(AuthLoading());
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        emit(AuthFailure("No user is logged in"));
        return;
      }
      final supabase = Supabase.instance.client;
      final String userId = const Uuid().v4();

      String? imageUrl;
      if (imageFile != null) {
        final fileExt = imageFile.path
            .split('.')
            .last;
        final filePath = 'public/$userId.$fileExt';

        final fileBytes = await imageFile.readAsBytes();

        final storageResponse = await supabase.storage
            .from('event-images')
            .uploadBinary(
          filePath,
          fileBytes,
          fileOptions: FileOptions(contentType: 'image/$fileExt'),
        );

        imageUrl = supabase.storage.from('event-images').getPublicUrl(filePath);
      }
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update(
        {
          'name': name,
          'phone': phone,
          'address': address,
          'imagePath': imageUrl
        },
      );
      if (newPassword != null && newPassword.isNotEmpty) {
        await user.updatePassword(newPassword);
      }
      UserModel updatedUser = UserModel(
          name: name,
          email: user.email,
          phone: phone,
          address: address,
          imagePath: imageUrl
      );

      emit(AuthSuccess(updatedUser));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<bool> verifyPassword(String password) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null || user.email == null) {
        emit(AuthFailure("No user is logged in"));
        return false;
      }
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );

      await user.reauthenticateWithCredential(credential);
      return true;
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? "Wrong password"));
      return false;
    } catch (e) {
      emit(AuthFailure(e.toString()));
      return false;
    }
  }

  Future<void> updatePassword(String password) async {
    emit(AuthLoading());
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (password != null && password.isNotEmpty) {
        await user!.updatePassword(password);
      }
      emit(
        AuthSuccess(
          UserModel(
              name: user!.displayName,
              email: user.email,
              phone: user.phoneNumber,
              imagePath: user.photoURL
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      print(e.message);
      emit(
        AuthFailure(e.message ?? 'An error occurred while updating password.'),
      );
    } catch (e) {
      print(e);
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> reauthenticateAndUpdateEmail({
    required String currentEmail,
    required String currentPassword,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final credential = EmailAuthProvider.credential(
        email: currentEmail,
        password: currentPassword,
      );

      await user!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print("Error: ${e.code} - ${e.message}");
    }
  }

}
