import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../colors/app_colors.dart';

class ShimmerImageVideoTitleAndDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h, left: 16.w, right: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 4.h),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
           highlightColor: AppColors.gold.withOpacity(0.1),

            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2.r,
                    blurRadius: 5.r,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Container(
                  height: 184.r,
                  width: double.infinity,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 12.r),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
                               highlightColor: AppColors.gold.withOpacity(0.1),

            child: Container(
              width: double.infinity,
              height: 16.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12.r),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
                               highlightColor: AppColors.gold.withOpacity(0.1),

            child: Container(
              width: double.infinity,
              height: 36.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12.r),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
                             highlightColor: AppColors.gold.withOpacity(0.1),

            child: Container(
              width: double.infinity,
              height: 12.sp,
              color: Colors.white,
            ),
          ),
          const Divider(),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
