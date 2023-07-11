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

      // final User user = userCredential.user!;
      final student =   await getStudentDataFromFirebase();

      if (student == null) {
        emit(AuthError("Student does not exist or something is wrong"));
      }
      else{
 emit(AuthLoginSuccess(successMessage: "Login successful",student: student));
      }

     
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

// Logout method
  Future<void> logout() async {
    try {
      // emit(AuthLoading());
      await _firebaseAuth.signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // Sign up method
  Future<void> signUp(String email, String password, String username) async {
         emit(AuthLoading());
   
    try {


      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final student =
          Student(uid: userCredential.user!.uid, username: username);

    await  createStudentDocument(student).then((value) =>  emit(AuthSignUpSuccess(successMessage: "Sign up successful")));
      // final User user = userCredential.user!;
     
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> createStudentDocument(Student student)async {
    // Replace with your desired student ID

   await FirebaseFirestore.instance
        .collection('students')
        .doc(student.uid)
        .set(student.toJson())
        .then((value) {
      print("Student document created successfully!");
    }).catchError((error) {
      print("Failed to create student document: $error");
    });
  }

  Future<Student?> getStudentDataFromFirebase() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('students')
          .doc(userId)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        final student = Student.fromJson(data);
        return student;
        // Process the data as needed
      } else {
        // Document does not exist
        print("Document student does not exist");
        return null;
      }
    } catch (err) {
      print(err.toString());
      return null;
    }
  }
}
