import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ytyt/colors/app_colors.dart';
import 'package:ytyt/features/auth/view/screens/login_screen.dart';
import 'package:ytyt/features/bottom_nav_screen/bottom_nav_screen.dart';
import 'package:ytyt/features/home/views/screens/home_screen_silver.dart';
import 'package:ytyt/models/student_modal.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/auth_state.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();

  late final AuthCubit _authCubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authCubit = BlocProvider.of<AuthCubit>(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

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

        //    SvgPicture.asset('assets/auth_svg_images/rocket_laptop.svg'),
             Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 28.h, 0, 0),
                  child: TextFormField(
                    controller: _usernameController,
                    autofocus: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: GoogleFonts.readexPro(
                          fontSize: 14.sp, fontWeight: FontWeight.normal),
                      hintText: 'What do we call you?',
                      hintStyle: GoogleFonts.readexPro(
                          fontSize: 14.sp, fontWeight: FontWeight.normal),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color(0xffE0E3E7),
                          width: 2.w,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2.w,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.w,
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.w,
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      contentPadding:
                          const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                    ),
                    style: GoogleFonts.readexPro(
                        fontSize: 14.sp, fontWeight: FontWeight.normal),
                    // validator:
                    //     _model.emailControllerValidator.asValidator(context),
                  ),
                ),
             Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 28.h, 0, 0),
                  child: TextFormField(
                    controller: _emailController,
                    autofocus: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Email',
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
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2.w,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.w,
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.w,
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      contentPadding:
                          const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                    ),
                    style: GoogleFonts.readexPro(
                        fontSize: 14.sp, fontWeight: FontWeight.normal),
                    // validator:
                    //     _model.emailControllerValidator.asValidator(context),
                  ),
                ),
            const SizedBox(height: 12.0),
            Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: TextFormField(
                    controller: _passwordController,
                    autofocus: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: GoogleFonts.readexPro(
                          fontSize: 14.sp, fontWeight: FontWeight.normal),
                      hintText: 'Enter your password...',
                      hintStyle: GoogleFonts.readexPro(
                          fontSize: 14.sp, fontWeight: FontWeight.normal),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color(0xffE0E3E7),
                          width: 2.w,
                        ),
                        borderRadius: BorderRadius.circular(8),
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
             SizedBox(height: 24.h,),
            ElevatedButton(
              onPressed: () {
                // Handle sign up logic here
                String email = _emailController.text;
                String password = _passwordController.text;
                _authCubit.signUp(email, password, _usernameController.text);
                // Perform sign up operations with the entered data
              },
              style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1000),
              ),
            ),
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
                    return const CircularProgressIndicator(color: AppColors.gold,);
                  } else if (state is AuthSignUpSuccess) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
});
                  }
                  return  Text("Sign up",style: GoogleFonts.readexPro(color:AppColors.gold),);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // final FirebaseAuth _auth = FirebaseAuth.instance;

  // Future<void> signUp(String email, String password, String username) async {
  //   try {
  //     UserCredential userCredential =
  //         await _auth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     final student =
  //         Student(uid: userCredential.user!.uid, username: username);
  //     student.toJson();
  //     createStudentDocument(student);
  //     // Successful sign-up
  //     print('Sign-up successful. User ID: ${userCredential.user!.uid}');
  //   } catch (error) {
  //     // Sign-up failed
  //     print('Sign-up failed: $error');
  //   }
  // }

  // void createStudentDocument(Student student) {
  //   // Replace with your desired student ID

  //   FirebaseFirestore.instance
  //       .collection('students')
  //       .doc(student.uid)
  //       .set(student.toJson())
  //       .then((value) {
  //     print("Student document created successfully!");
  //   }).catchError((error) {
  //     print("Failed to create student document: $error");
  //   });
  // }
}
