import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ytyt/colors/app_colors.dart';
import 'package:ytyt/features/all_notes/cubit/all_note_cubit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../models/vid_id_and_list_of_notes_of_that.dart';
import '../widgets/all_video_notes_widget.dart';

class AllNotesScreen extends StatefulWidget {
  const AllNotesScreen({super.key});

  @override
  State<AllNotesScreen> createState() => _AllNotesScreenState();
}

class _AllNotesScreenState extends State<AllNotesScreen> {
  late AllNoteCubit allNotesCubit;
  List<VidIdAndListOfNotesModal> vidIdAndListOfNotes = [];

  @override
  void initState() {
    super.initState();
    allNotesCubit = BlocProvider.of<AllNoteCubit>(context);
    allNotesCubit.getVidIdsAndNotesOfThat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.replay),
//             onPressed: () {
//               allNotesCubit.getVidIdsAndNotesOfThat();
//               Fluttertoast.showToast(
//   msg: "Please refresh",
//   toastLength: Toast.LENGTH_SHORT,
//   gravity: ToastGravity.BOTTOM,
//   backgroundColor: Colors.black87,
//   textColor: Colors.white,
// );
//             },
//           )
//         ],
        title: Text(
          "Your notes",
          style: GoogleFonts.readexPro(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<AllNoteCubit, AllNotesState>(
          builder: (context, state) {
            if (state is AllNotesLoadingSuccess) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.w),
                child: Scrollbar(
                  child: ListView.builder(
                    itemCount: state.vidIdAndListOfNotesModalList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AllVideoNotesWidget(
                        vidIdAndListOfNotesModal:
                            state.vidIdAndListOfNotesModalList[index],
                      );
                    },
                  ),
                ),
              );
            }
            if (state is AllNotesLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.gold),
              );
            }
            if (state is AllNotesLoadingError) {
              return Center(
                child: Text(
                  state.errorMessage,
                  style: GoogleFonts.readexPro(),
                ),
              );
            }
            if (state is AllNotesNoNotes) {
              return Center(
                child: Text(
                  "You have not made any note",
                  style: GoogleFonts.readexPro(fontSize: 16.sp),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
