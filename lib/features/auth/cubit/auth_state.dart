// ignore_for_file: public_member_api_docs, sort_constructors_first
// Authentication State



import '../../../models/student_modal.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthData extends AuthState {
  final Student student;
  AuthData({
    required this.student,
  });
}

class AuthError extends AuthState {
  final String errorMessage;

  AuthError(this.errorMessage);
}

class AuthLoginSuccess extends AuthState {
  final String successMessage;
   final Student student;
  AuthLoginSuccess({
    required this.successMessage,required this.student
  });
}

class AuthSignUpSuccess extends AuthState {
  final String successMessage;

  AuthSignUpSuccess({required this.successMessage});
 

}

