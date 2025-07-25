import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventify_app/features/auth/cubit/auth_state.dart';
import 'package:eventify_app/features/auth/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      UserModel user = UserModel(name: result.user!.displayName, email: email);
      emit(AuthSuccess(user));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? "Unknown error"));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signUp(
    String email,
    String password,
    String name,
    String phone,
    String address,
  ) async {
    emit(AuthLoading());
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
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
      emit(AuthInitial());
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
}
