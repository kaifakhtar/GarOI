import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ytyt/colors/app_colors.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return  Dialog(
      child: Padding(
        padding:  EdgeInsets.all(20.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: AppColors.gold,),
            SizedBox(width: 20.w),
             Text("Please wait...",style: GoogleFonts.readexPro(),),
          ],
        ),
      ),
    );
  }
}
