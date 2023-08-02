import 'package:auto_route/annotations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../auth/cubit/auth_cubit.dart';
import '../../../auth/cubit/auth_state.dart';
import '../../../auth/view/screens/login_screen.dart';
import '../../../auth/view/screens/signup_screen.dart';

@RoutePage()
class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final AuthCubit _authCubit;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _logout(BuildContext context) async {
    await _auth.signOut().then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  void initState() {

    super.initState();
    _authCubit = BlocProvider.of<AuthCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'User Profile',
          style: GoogleFonts.readexPro(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: Colors.black.withOpacity(.1),
                      width: 2.0,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Are you sure you want to logout?",
                        style: GoogleFonts.readexPro(fontSize: 18.sp),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        tileColor: Colors.grey[200],
                        title: const Text('Logout'),
                        leading: const Icon(Icons.logout),
                        onTap: () {
                          _authCubit.logout().then((value) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const LoginScreen()));
                          });

                          // error catching
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 400.h,
                ),
                Text(
                  "Wait for more features to be available",
                  style: GoogleFonts.readexPro(fontSize: 18.sp),
                  textAlign: TextAlign.center,
                ),
                const Divider(),
                const Spacer(),
                OutlinedButton(
                    onPressed: () {
                      _deleteAccount(context);
                    },
                    child: const Text(
                      "Delete account",
                      style: TextStyle(color: Colors.red),
                    ))
              ],
            );
          },
        ),
      ),
    );
  }

  void _deleteAccount(BuildContext context) {
    _showConfirmationDialog(context).then((confirmed) {
      if (confirmed != null && confirmed) {
        _showLoadingDialog(context);

        final User? user = _auth.currentUser;
        if (user == null) {
          // Handle the case when no user is signed in.
          Navigator.pop(context); // Close the loading dialog
          return;
        }

        _firestore.collection('students').doc(user.uid).delete().then((_) {
          user.delete().then((_) {
            // Account successfully deleted, navigate to sign-up page
            Navigator.pop(context); // Close the loading dialog
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignUpScreen()),
            );
          }).catchError((error) {
            // Handle user deletion error
            Navigator.pop(context); // Close the loading dialog
            _showErrorDialog(context);
             if(kDebugMode)print("Error deleting student account: $error");
          });
        }).catchError((error) {
          // Handle Firestore document deletion error
          Navigator.pop(context); // Close the loading dialog
          _showErrorDialog(context);
         if(kDebugMode) print("Error deleting account: $error");
        });
      }
    });
  }

  Future<bool?> _showConfirmationDialog(BuildContext context) {
    return showDialog<bool?>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Are you sure you want to delete your account?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false); // Not confirmed
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true); // Confirmed
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>  AlertDialog(
        title: const Text('Deleting Account'),
        content: Row(
          children: [
            const CircularProgressIndicator(),
            SizedBox(width: 16.w),
            const Text('Please wait...'),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context) {
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
  }
}
