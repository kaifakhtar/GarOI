import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:ytyt/colors/app_colors.dart';
import 'package:ytyt/features/auth/cubit/auth_state.dart';

import '../../../bottom_nav_screen/bottom_nav_screen.dart';
import '../../cubit/auth_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final AuthCubit _authCubit;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authCubit = BlocProvider.of<AuthCubit>(context);

    // _model.emailController ??= TextEditingController();
    // _model.textController2 ??= TextEditingController();
  }

  @override
  void dispose() {
    // _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 44, 16, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 56, 0, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://picsum.photos/seed/942/600',
                        width: 325,
                        height: 168,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 32.h, 0, 0),
                  child: Text(
                    'Log in',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.readexPro(
                        fontSize: 32.sp, fontWeight: FontWeight.w600),
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
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      _authCubit.login(
                          _emailController.text, _passwordController.text);

                      print('Button pressed ...');
                    },
                    child: BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return const CircularProgressIndicator(color: AppColors.gold,);
                        } else if (state is AuthLoginSuccess) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const BottomNavScreen()));
});
                        }
                        return const Text('Login');
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No account?',
                        style: GoogleFonts.readexPro(
                            fontSize: 14.sp, fontWeight: FontWeight.normal),
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
}
