import 'package:auto_route/annotations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ytyt/colors/app_colors.dart';
import 'package:ytyt/features/all_notes/view/screens/all_notes_screen.dart';
import 'package:ytyt/features/home/views/screens/home_screen_silver.dart';
import 'package:ytyt/screens/home_screen.dart';

import '../askQ/view/screen/ask_question_screen.dart';
import '../importants/view/screens/importants_screen.dart';

@RoutePage()
class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HomeScreenSilver(),
    const AllNotesScreen(),
    const AskQuesScreen(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUpPushNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: AppColors.blackTintGold,
            type: BottomNavigationBarType.fixed,
            elevation: 4,
            onTap: (selectedIndex) {
              setState(() {
                _currentIndex = selectedIndex;
              });
            },
            currentIndex: _currentIndex,
            selectedItemColor: AppColors.gold,
            unselectedItemColor: AppColors.gold.withOpacity(0.7),
            selectedFontSize: 16.sp,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Iconsax.home,
                  weight: 5,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.note_square),
                label: "Notes",
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.message_question),
                label: "Ask",
              )
            ]));
  }

  void setUpPushNotification() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    fcm.subscribeToTopic('update');
    fcm.subscribeToTopic('news');
    // String? token = await fcm.getToken();
    // print(token);
  }
}
