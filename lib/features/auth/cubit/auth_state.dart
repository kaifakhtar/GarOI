// ignore_for_file: public_member_api_docs, sort_constructors_first
// Authentication State


abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String errorMessage;

  AuthError(this.errorMessage);
}

class AuthSuccess extends AuthState {
final String successMessage;
  AuthSuccess({
    required this.successMessage,
  });
}
