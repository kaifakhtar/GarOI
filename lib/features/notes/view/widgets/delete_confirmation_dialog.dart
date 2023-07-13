import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ytyt/colors/app_colors.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final VoidCallback onDelete;

  const DeleteConfirmationDialog({Key? key, required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Confirmation'),
      content: const Text('Are you sure you want to delete?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(4.r),
            // ),
            // padding: EdgeInsets.all(14.h),
          ),
          onPressed: onDelete,
          child: const Text(
            'Delete',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
