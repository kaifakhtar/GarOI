import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }


void handleFirebaseAuthException(BuildContext context, FirebaseAuthException e) {
  String errorMessage;
  switch (e.code) {
    case 'invalid-email':
      errorMessage = 'Invalid email address.';
      break;
    case 'missing-android-pkg-name':
      errorMessage = 'Missing Android package name.';
      break;
    case 'missing-continue-uri':
      errorMessage = 'Missing continue URL.';
      break;
    case 'missing-ios-bundle-id':
      errorMessage = 'Missing iOS Bundle ID.';
      break;
    case 'invalid-continue-uri':
      errorMessage = 'Invalid continue URL.';
      break;
    case 'unauthorized-continue-uri':
      errorMessage = 'Unauthorized continue URL.';
      break;
    case 'user-not-found':
      errorMessage = 'Student not found.';
      break;
    default:
      errorMessage = 'An error occurred: ${e.message}';
      break;
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Authentication Error'),
        content: Text(errorMessage),
        actions: <Widget>[
          TextButton(
            // ignore: prefer_const_constructors
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


  Future<void> _passwordReset(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim())
          .then((value) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Password Reset Link Sent'),
              content:
                  const Text('A password reset link has been sent to your email.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      });

      // If the password reset email is sent successfully, show a dialog
    }  on FirebaseAuthException catch (e) {
  // Handle the specific error using the switch case
  handleFirebaseAuthException(context,e);
} catch (err) {
     if(kDebugMode)  print(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text("Forgot Password",
            style: GoogleFonts.readexPro(color: Colors.black)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter your email we will send you a password reset link",
              style: GoogleFonts.readexPro(fontSize: 20.sp),
            ),
            SizedBox(
              height: 16.h,
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 12.h, 0, 0),
              child: TextFormField(
                controller: _emailController,
                autofocus: true,

                decoration: InputDecoration(
                  //   labelText: 'Password',
                  labelStyle: GoogleFonts.readexPro(
                      fontSize: 14.sp, fontWeight: FontWeight.normal),
                  hintText: 'Enter your email...',

                  hintStyle: GoogleFonts.readexPro(
                      fontSize: 14.sp, fontWeight: FontWeight.normal),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color(0xffE0E3E7),
                      width: 2.w,
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.w,
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2.w,
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2.w,
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                style: GoogleFonts.readexPro(
                    fontSize: 14.sp, fontWeight: FontWeight.normal),
                // validator:
                //     _model.textController2Validator.asValidator(context),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    padding: EdgeInsets.all(14.h),
                  ),
                  onPressed: () {
                    _passwordReset(context);
                  },
                  child: const Text("Send link"),
                ))
          ],
        ),
      ),
    );
  }
}
