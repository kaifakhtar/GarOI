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

    homebloc = BlocProvider.of<HomeBloc>(context);
    homebloc.add(HomeLoadPlaylist());
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
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
                SliverPersistentHeader(
                  pinned: true,
                  delegate: MyHeaderDelegate(),
                ),
                SliverToBoxAdapter(
                    child: Column(
                  children: [
                    const Text("Playlist"),
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
                      style: GoogleFonts.lato(
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
                    const SizedBox(height: 16),
                    Text(
                      'Learn authentic knowledge\n from the comfort of you home',
                      style: GoogleFonts.lato(
                        fontSize: 16.sp,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                )
              else
                Text(
                  'Playlist',
                  style: GoogleFonts.lato(
                    fontSize: 16.sp,
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
  double get maxExtent => 200;

  @override
  double get minExtent => 150;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
