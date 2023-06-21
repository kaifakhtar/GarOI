import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ytyt/colors/app_colors.dart';
import 'package:ytyt/features/home/bloc/home_bloc.dart';

import '../widgets/playlist_tile.dart';

class HomeScreenSilver extends StatefulWidget {
  const HomeScreenSilver({super.key});

  @override
  State<HomeScreenSilver> createState() => _HomeScreenSilverState();
}

class _HomeScreenSilverState extends State<HomeScreenSilver> {
  late HomeBloc homebloc;
  late ScrollController _scrollController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    homebloc = BlocProvider.of<HomeBloc>(context);
    homebloc.add(HomeLoadPlaylist());
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Reach the end of the list
      // Emit an event to fetch more videos
      print("In the _scrool");
      homebloc.add(HomeLoadMorePlaylist());

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
      backgroundColor: const Color.fromARGB(255, 252, 251, 247),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is HomeHasData) {
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  elevation: 1.h,
                  pinned: true,
                  expandedHeight: 150.h,
                  flexibleSpace: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return FlexibleSpaceBar(
                        centerTitle: true,
                        title: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            'Playlists',
                            style: GoogleFonts.readexPro(
                              color: Colors.black,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  backgroundColor: Colors.white,
                ),
                SliverToBoxAdapter(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 24.h,
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 16.w),
                    //   child: Text(
                    //     'Playlist',
                    //     style: GoogleFonts.readexPro(
                    //       fontSize: 20.sp,
                    //     ),
                    //   ),
                    // ),
                    ListView.builder(
                      // controller: _scrollController,
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
                )),
              ],
            );
          }
          return const Placeholder();
        },
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
