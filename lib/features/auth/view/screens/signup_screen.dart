import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ytyt/colors/app_colors.dart';
import 'package:ytyt/common_widgets/loading_dialog.dart';
import 'package:ytyt/features/auth/view/screens/login_screen.dart';
import 'package:ytyt/features/bottom_nav_screen/bottom_nav_screen.dart';
import 'package:ytyt/features/home/views/screens/home_screen_silver.dart';
import 'package:ytyt/models/student_modal.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ytyt/routes/routes_imports.gr.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/auth_state.dart';

@RoutePage()
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
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16.w, 44.h, 16.w, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 56.h, 0, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Image.network(
                        'https://fastly.picsum.photos/id/109/4287/2392.jpg?hmac=K5ytllhfakgsUEDFnY5ujHIGJTzELPQgVJjZMpRlfJY',
                        width: 325.w,
                        height: 168.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 32.h, 0, 0),
                  child: Text(
                    'Create Account',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.readexPro(
                        fontSize: 32.sp, fontWeight: FontWeight.w600),
                  ),
                ),
                //    SvgPicture.asset('assets/auth_svg_images/rocket_laptop.svg'),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 32.h, 0, 0),
                  child: TextFormField(
                    controller: _usernameController,
                    autofocus: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      //   labelText: 'Password',
                      labelStyle: GoogleFonts.readexPro(
                          fontSize: 14.sp, fontWeight: FontWeight.normal),
                      hintText: 'Enter your username...',
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12.h, 0, 0),
                  child: TextFormField(
                    controller: _emailController,
                    autofocus: true,
                    obscureText: false,
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

                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12.h, 0, 0),
                  child: TextFormField(
                    controller: _passwordController,
                    autofocus: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      //   labelText: 'Password',
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
                  height: 24.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle sign up logic here
                      String email = _emailController.text;
                      String password = _passwordController.text;
                      String username = _usernameController.text;
                      if (email.isNotEmpty &&
                          password.isNotEmpty &&
                          username.isNotEmpty) {
                        _authCubit.signUp(
                            email, password, _usernameController.text);
                      } else if (email.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Enter your email",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.sp);
                      } else if (password.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Enter your password",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.sp);
                      } else if (username.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Enter your username",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.sp);
                      }
                      // Perform sign up operations with the entered data
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      padding: EdgeInsets.all(14.h),
                    ),
                    child: BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthError) {
                          Navigator.of(context, rootNavigator: true).pop();
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
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return const LoadingDialog();
                              },
                            );
                          });
                        } else if (state is AuthSignUpSuccess) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const LoginScreen()));
                          });
                        }
                        return Text(
                          "Sign up",
                          style: GoogleFonts.readexPro(color: AppColors.gold),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12.h, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?  ',
                        style: GoogleFonts.readexPro(
                            fontSize: 14.sp, fontWeight: FontWeight.normal),
                      ),
                      GestureDetector(
                        onTap: () {
                          AutoRouter.of(context)
                              .replace(const LoginScreenRoute());
                        },
                        child: Text(
                          'Log in',
                          style: GoogleFonts.readexPro(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal,
                              color: AppColors.primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
