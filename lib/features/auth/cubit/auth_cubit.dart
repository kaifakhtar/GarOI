import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import '../../../models/student_modal.dart';
import 'auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';


// Authentication Cubit
class AuthCubit extends Cubit<AuthState> {

  final FirebaseAuth _firebaseAuth;
  AuthCubit(this._firebaseAuth) : super(AuthInitial());

  // Login method
  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());

      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User user = userCredential.user!;
     
      emit(AuthLoginSuccess(successMessage: "Login successful"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

// Logout method
  Future<void> logout() async {
    try {
      emit(AuthLoading());
      await _firebaseAuth.signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
  // Sign up method
  Future<void> signUp(String email, String password, String username) async {
    try {
      emit(AuthLoading());

       UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

final student =
          Student(uid: userCredential.user!.uid, username: username);

      createStudentDocument(student);
     // final User user = userCredential.user!;
      emit(AuthSignUpSuccess(successMessage: "Sign up successful"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void createStudentDocument(Student student) {
    // Replace with your desired student ID

    FirebaseFirestore.instance
        .collection('students')
        .doc(student.uid)
        .set(student.toJson())
        .then((value) {

      print("Student document created successfully!");

    }).catchError((error) {

      print("Failed to create student document: $error");
      
    });
  }
}