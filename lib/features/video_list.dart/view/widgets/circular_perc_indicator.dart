import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ytyt/colors/app_colors.dart';

class CircularPercentageIndicator extends StatelessWidget {
  final double percentage;
  final double radius;
  final Color backgroundColor;
  final Color progressColor;

  const CircularPercentageIndicator({super.key, 
    required this.percentage,
    this.radius = 50.0,
    this.backgroundColor = Colors.black12,
    this.progressColor = AppColors.gold,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: radius * 2,
      height: radius * 2,
      child: Stack(
        children: [
          Center(
            child: CircularProgressIndicator(
              value: percentage / 100,
              backgroundColor: backgroundColor,
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
            ),
          ),
          Center(
            child: Text(
              percentage.toStringAsFixed(0),
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.normal,
                color: progressColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
