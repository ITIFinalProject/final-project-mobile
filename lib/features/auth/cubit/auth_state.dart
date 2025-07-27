import 'package:eventify_app/features/auth/models/user_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserModel user;

  AuthSuccess(this.user);
}

class ResetPasswordSuccess extends AuthState {
  final String message;

  ResetPasswordSuccess(this.message);
}

class AuthLoggedOut extends AuthState {}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error);
}
