import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../auth/view/screens/signup_screen.dart';
// Import your sign-up screen file here

class AccountDeletionScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _deleteAccount(BuildContext context) async {
    try {
      final User? user = _auth.currentUser;
      if (user == null) {
        // Handle the case when no user is signed in.
        return;
      }

      await _firestore.collection('students').doc(user.uid).delete();
      await user.delete().then((value) {
         Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                SignUpScreen()), // Replace SignUpScreen with your actual sign-up screen widget
      );
      });

      // Account successfully deleted, navigate to sign-up page
     
    } catch (error) {
      // Show an error dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('An error occurred while deleting your account.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );

      // You can also log the error for debugging purposes
      print("Error deleting account: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Account'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _deleteAccount(context),
          child: const Text('Delete My Account'),
        ),
      ),
    );
  }
}
