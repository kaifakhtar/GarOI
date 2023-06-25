import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ytyt/colors/app_colors.dart';
import 'package:ytyt/features/home/views/screens/home_screen_silver.dart';
import 'package:ytyt/screens/home_screen.dart';

import '../askQ/view/screen/ask_question_screen.dart';
import '../importants/view/screens/importants_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HomeScreenSilver(),
    const ImportantsScreen(),
    const AskQuesScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: GNav(
                backgroundColor: Colors.white,
                gap: 8.w,
                activeColor: AppColors.gold,
                iconSize: 20.h,
                color: Colors.black,
                tabBackgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                tabBorderRadius: 1000.r,
                tabs: const [
                  GButton(
                    icon: Iconsax.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon:  Iconsax.star,
                    text: 'Importants',
                  ),
                  GButton(
                    icon: 
                         Iconsax.message_question,
                    text: 'Ask',
                  ),
                ],
                selectedIndex: _currentIndex,
                onTabChange: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                }),
          ),
        ));
  }
}
