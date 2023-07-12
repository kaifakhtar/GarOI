import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ytyt/colors/app_colors.dart';
import 'package:ytyt/features/bottom_nav_screen/bottom_nav_screen.dart';
import 'package:ytyt/routes/routes_imports.gr.dart';

import '../../models/student_modal.dart';
import '../auth/cubit/auth_cubit.dart';
import '../auth/view/screens/login_screen.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = true;
  late final AuthCubit _authCubit;
  @override
  void initState() {
    super.initState();
    _authCubit = BlocProvider.of<AuthCubit>(context);
    checkUserLoggedIn();
  }

  Future<void> checkUserLoggedIn() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? currentUser = auth.currentUser;
    await Future.delayed(const Duration(seconds: 2)); // Simulate a delay

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
      if (currentUser != null) {
        //_ User is logged in, navigate to home screen
        //  await _authCubit.getStudentDataFromFirebase().then((student) {

        //    if(student != null) {
        //     AutoRouter.of(context).replace(const BottomNavScreenRoute());
        //   } else {
        //    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Cannot get the data, please try again later")));
        //   }
        //   return null;
        // });
        _authCubit.getStudentDataOnStartup().then((value) =>
            AutoRouter.of(context).replace(const BottomNavScreenRoute()));
      } else {
        // User is not logged in, navigate to login screen
        AutoRouter.of(context).replace(const LoginScreenRoute());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Garden of Ilm',
              style: GoogleFonts.readexPro(
                fontSize: 32.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.gold,
              ),
            ),
            const SizedBox(height: 16),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
