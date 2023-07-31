import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../video_player/view/widgets/need_permission.dart';
import '../../cubit/pdf_cubit.dart';

class SelectPdfAndView extends StatefulWidget {
  const SelectPdfAndView({super.key});

  @override
  State<SelectPdfAndView> createState() => _SelectPdfAndViewState();
}

class _SelectPdfAndViewState extends State<SelectPdfAndView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
        alignment: Alignment.center,
        child: BlocBuilder<PdfCubit, PdfState>(
          builder: (context, state) {
            if (state is PdfStateInitial) {
              return Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80.h,
                  ),
                  Text(
                    "Open the book while watching...",
                    style: GoogleFonts.readexPro(
                        fontSize: 16.sp, color: Colors.black54),
                  ),
                  SizedBox(
                    height: 48.h,
                  ),
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        requestStoragePermission(context).then((value) {
                          if (value) {
                            BlocProvider.of<PdfCubit>(context).selectPdf();
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Iconsax.book_1, // Replace with your desired icon
                            size: 40.h,
                            color: Colors
                                .black54, // Adjust the icon size as needed
                          ),
                          SizedBox(
                              height: 12
                                  .h), // Add some spacing between the icon and text
                          Text(
                            "Select a book",
                            style: GoogleFonts.readexPro(
                                fontSize: 20.sp, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            if (state is PdfStateLoaded) {
              //   File pdfFile = File(state.path[0]);
              return Container(
                //// width:
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: SfPdfViewer.memory(state.pdfBytes),
                    ),
                    Positioned(
                      top: 0.0,
                      left: 0.0,
                      child: IconButton(
                          onPressed: () {
                            // Add button functionality here
                            BlocProvider.of<PdfCubit>(context).reset();
                          },
                          icon: const Icon(Icons.arrow_back_ios_sharp)),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ));
  }

  Future<bool> requestStoragePermission(BuildContext context) async {
    final permission = Permission.storage.request();
    if (await permission.isGranted) {
      // Permission is granted, you can proceed with your app logic here
      if (kDebugMode) print("permission granted");
      return true;
    } else {
      // If permissions are denied, you can show a dialog or request again
      if (await permission.isPermanentlyDenied) {
        if (kDebugMode) print("permission permanently denied");

        if (mounted) {
          showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return NeedPermissionBottomSheet(
                  message: "We need permission to select the book.",
                  buttonText: "Open Settings",
                  onButtonPressed: () {
                    Navigator.pop(context); // Close the bottom sheet
                    openAppSettings(); // Open the app settings
                  },
                );
              });
        } // The user has permanently denied storage permission, you can open settings to prompt them manually

        // openAppSettings();
      } else {
        if (kDebugMode) print("again requesting permission ");
        // The user denied storage permission, you can request again
        if (mounted) requestStoragePermission(context);
      }
    }
    return false;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
