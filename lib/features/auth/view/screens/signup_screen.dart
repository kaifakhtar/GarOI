import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ytyt/models/student_modal.dart';


class SignUpScreen extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle sign up logic here
                String email = usernameController.text;
                String password = passwordController.text;
                signUp(email, password);
                // Perform sign up operations with the entered data
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final student = Student(uid: userCredential.user!.uid, username: "User");
      student.toJson();
      createStudentDocument(student);
      // Successful sign-up
      print('Sign-up successful. User ID: ${userCredential.user!.uid}');
    } catch (error) {
      // Sign-up failed
      print('Sign-up failed: $error');
    }
  }

  void createStudentDocument(Student student) {
   // Replace with your desired student ID

    FirebaseFirestore.instance.collection('students').doc(student.uid).set(student.toJson()).then((value) {
      print("Student document created successfully!");
    }).catchError((error) {
      print("Failed to create student document: $error");
    });
  }
}
