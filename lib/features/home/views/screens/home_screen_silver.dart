import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ytyt/colors/app_colors.dart';
import 'package:ytyt/features/auth/cubit/auth_cubit.dart';
import 'package:ytyt/features/home/bloc/home_bloc.dart';

import '../../../auth/cubit/auth_state.dart';

import '../../../user_profile/view/screens/user_profile_screen.dart';
import '../widgets/playlist_tile.dart';
import '../widgets/playlist_tile_shimmer.dart';

class HomeScreenSilver extends StatefulWidget {
  const HomeScreenSilver({Key? key}) : super(key: key);

  @override
  State<HomeScreenSilver> createState() => _HomeScreenSilverState();
}

class _HomeScreenSilverState extends State<HomeScreenSilver> {
  late HomeBloc homebloc;
  late AuthCubit authCubit;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    homebloc = BlocProvider.of<HomeBloc>(context);
    //  authCubit = BlocProvider.of<AuthCubit>(context);
    homebloc.add(HomeLoadPlaylist());
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Reach the end of the list
      // Emit an event to fetch more videos
     if(kDebugMode)  print("In the _scrool");
      // homebloc.add(HomeLoadMorePlaylist());

      // Update the state in the BLoC
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
                automaticallyImplyLeading: false, // Remove back button
                iconTheme: const IconThemeData(color: Colors.black),
                collapsedHeight: 100.h,
                expandedHeight: 180.h,
                centerTitle: true,

                // title: Text(
                //   "Garden of Ilm",
                //   style: GoogleFonts.readexPro(color: Colors.black),
                // ),
                flexibleSpace: Center(
                    child: Padding(
                  padding: EdgeInsets.all(8.h),
                  child: CircleAvatar(
                    radius: 100.r,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/goi.jpg',
                        // width: 550, // adjust the width as needed
                        // height: 550, // adjust the height as needed
                      ),
                    ),
                  ),
                )),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 16.w, top: 8.h),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserProfilePage()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(16.0),
                          // border: Border.all(
                          //   color: const Color.fromARGB(255, 255, 255, 255),
                          //   width: 2.0,
                          // ),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        // color: AppColors.gold.withOpacity(.5),
                        child: Icon(
                          Icons.person,
                          size: 24.h,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
                elevation: 1.h,
                pinned: true,
                // expandedHeight: 100.h,
                // flexibleSpace: LayoutBuilder(
                //   builder: (BuildContext context, BoxConstraints constraints) {
                //     return FlexibleSpaceBar(
                //       centerTitle: true,
                //       title: Align(
                //         alignment: Alignment.bottomCenter,
                //         child: Text(
                //           'Playlists',
                //           style: GoogleFonts.readexPro(
                //             color: Colors.black,
                //             fontSize: 20.sp,
                //             fontWeight: FontWeight.w500,
                //           ),
                //         ),
                //       ),
                //     );
                //   },
                // ),
                backgroundColor: AppColors.gold.withOpacity(.9)),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 100.h,
                child: Padding(
                  padding: EdgeInsets.only(left: 16.h, right: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 16.h,
                      ),
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          if (state is AuthLoginSuccess) {
                            return FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text("${state.student.username}!",
                                  style: GoogleFonts.readexPro(
                                      letterSpacing: 1.2,
                                      color: Colors.black87,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w600)),
                            );
                          }
                          return Text("No student data",
                              style: GoogleFonts.readexPro(
                                  color: Colors.black87,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w600));
                        },
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text("Pick up from my garden",
                          style: GoogleFonts.readexPro(
                              color: Colors.black54, fontSize: 20)),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return ShimmerList();
                  }
                  if (state is HomeHasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.listOfPlaylist.length,
                          itemBuilder: (BuildContext context, int index) {
                            return PlaylistTile(
                              playlist: state.listOfPlaylist[index],
                            );
                          },
                        ),
                      ],
                    );
                  }
                  if (state is HomeError) {
                    return Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/error_goi.jpg',
                            width: 300.w, // adjust the width as needed
                            height: 300.h, // adjust the height as needed
                          ),
                        ),
                        OutlinedButton.icon(
                            onPressed: () {
                              homebloc.add(HomeLoadPlaylist());
                            },
                            icon: const Icon(
                              Icons.replay_rounded,
                              color: Colors.black,
                            ),
                            label: const Text(
                              "Retry",
                              style: TextStyle(color: Colors.black),
                            ))
                      ],
                    );
                  }
                  return const Placeholder();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  bool isPinned = true;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    if (shrinkOffset > 150) {
      isPinned = false;
    } else {
      isPinned = true;
    }

    return Container(
      color: AppColors.blackTintGold,
      child: AnimatedAlign(
        alignment: isPinned ? Alignment.bottomLeft : Alignment.center,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        child: Padding(
          padding: EdgeInsets.only(left: 16.w, bottom: 16.h, right: 16.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isPinned)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to',
                      style: GoogleFonts.outfit(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                    // const SizedBox(height: 4),
                    Text(
                      'Garder Of Ilm',
                      style: GoogleFonts.libreBaskerville(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.gold,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Learn authentic knowledge\nfrom the comfort of you home',
                      style: GoogleFonts.outfit(
                        fontSize: 16.sp,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                )
              else
                Text(
                  'Playlist',
                  style: GoogleFonts.outfit(
                    fontSize: 20.sp,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 300.h;

  @override
  double get minExtent => 200.h;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
