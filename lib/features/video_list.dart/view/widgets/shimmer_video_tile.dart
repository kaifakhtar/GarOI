import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shimmer/shimmer.dart';
import 'package:ytyt/colors/app_colors.dart';

class ShimmerVideoListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: AppColors.gold.withOpacity(0.1),
          child: Ink(
            color: Colors.white,
            child: InkWell(
              splashColor: AppColors.gold.withOpacity(0.2),
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: Colors.white,
                      ),
                      width: 150.w,
                      height: 90.h,
                    ),
                    SizedBox(width: 16.w),
                    SizedBox(
                      width: 160.w,
                      height: 80.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 12.sp,
                            color: Colors.white,
                          ),
                          SizedBox(height: 8.h),
                          Container(
                            width: double.infinity,
                            height: 10.sp,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
