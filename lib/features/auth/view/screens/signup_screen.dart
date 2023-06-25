import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ytyt/models/student_modal.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

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
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle sign up logic here
                String email = _emailController.text;
                String password = _passwordController.text;
                signUp(email, password, _usernameController.text);
                // Perform sign up operations with the entered data
              },
              child: const Text('Sign up'),
            ),
          ],
        ),
      ),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp(String email, String password, String username) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final student =
          Student(uid: userCredential.user!.uid, username: username);
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
