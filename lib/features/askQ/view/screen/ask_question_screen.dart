import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AskQuesScreen extends StatefulWidget {
  const AskQuesScreen({super.key});

  @override
  State<AskQuesScreen> createState() => _AskQuesScreenState();
}

class _AskQuesScreenState extends State<AskQuesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Ask your question",
                style: GoogleFonts.readexPro(
                    fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.h),
              Text(
                "Wait for this feature",
                style: GoogleFonts.readexPro(
                    fontSize: 16.sp, color: Colors.black45),
              ),
              SizedBox(
                height: 100.h,
              ),
              Container(
                alignment: Alignment.center,
                height: 100.h,
                width: 300.h,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(16.r)),
                // width: 250.0,
                child: DefaultTextStyle(
                  style: GoogleFonts.readexPro(
                    fontSize: 20.sp,
                    color: Colors.black,
                  ),
                  child: AnimatedTextKit(
                    isRepeatingAnimation: true,
                    animatedTexts: [
                      TypewriterAnimatedText('Watched a lesson?',
                          speed: const Duration(milliseconds: 100)),
                      TypewriterAnimatedText('Have questions?',
                          speed: const Duration(milliseconds: 100)),
                      TypewriterAnimatedText('Just ask.',
                          speed: const Duration(milliseconds: 100)),
                    ],
                    onTap: () {
                      print("Tap Event");
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
