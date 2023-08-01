import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ytyt/colors/app_colors.dart';
import 'package:ytyt/routes/routes_imports.gr.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../auth/cubit/auth_cubit.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // bool _isLoading = true;
  late final AuthCubit _authCubit;
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _authCubit = BlocProvider.of<AuthCubit>(context);
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    checkUserLoggedIn();
  }

  @override
  void dispose() {
    // Dispose of the AnimationController
    _animationController.dispose();
    super.dispose();
  }

  Future<void> checkUserLoggedIn() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? currentUser = auth.currentUser;
    await Future.delayed(const Duration(seconds: 2)); // Simulate a delay

    if (mounted) {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Garden of Ilm',
            style: GoogleFonts.readexPro(
              fontSize: 32.sp,
              fontWeight: FontWeight.normal,
              color: AppColors.gold,
            ),
          ),
          SizedBox(height: 60.h),
          
          SpinKitSquareCircle(
            color: AppColors.gold,
            size: 30.h,
            controller: _animationController,
          ),
          // SizedBox(height:400.h),
          // Padding(
          //   padding:  EdgeInsets.all(20.h),
          //   child: Text("Whoever takes a path upon which to obtain knowledge, Allah makes the path to Paradise easy for him.",
          //  textAlign: TextAlign.center,
          //   style: GoogleFonts.readexPro(color:AppColors.gold, fontSize: 14.sp),            ),
          // )
        ],
      ),
    );
  }
}
