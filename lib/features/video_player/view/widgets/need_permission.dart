
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NeedPermissionBottomSheet extends StatelessWidget {
  final String message;
  final String buttonText;
  final VoidCallback onButtonPressed;

  const NeedPermissionBottomSheet({super.key, 
    required this.message,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
           Text(
           message,
            textAlign: TextAlign.center,
            style: GoogleFonts.readexPro(fontSize: 16.sp),
          ),
           SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: onButtonPressed,
            child:  Text("Open Settings",style: GoogleFonts.readexPro(color: Colors.black),),
          ),
        ],
      ),
    );
  }
}
