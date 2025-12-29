import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_college/View/Student/Profile/ProfileScreen.dart';
import '../../../Cubits/Students/ProfileScreenViewModel.dart';
import '../../../utils/colors.dart';

class DeleteDialog extends StatelessWidget {
  final String message;
  final String? subMessage;
  final VoidCallback? onDismiss;
  final VoidCallback? result;
  final String? image;
  final String? overlayImage;
  final Map<String, dynamic>? examData;

  const DeleteDialog({
    Key? key,
    required this.message,
    this.subMessage,
    this.onDismiss,
    this.result,
    this.image,
    this.overlayImage,
    this.examData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onDismiss != null) onDismiss!();
      },
      child: AlertDialog(
        backgroundColor: MyColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                if (image != null) SvgPicture.asset(image!),
                if (overlayImage != null) SvgPicture.asset(overlayImage!),
              ],
            ),

            SizedBox(height: 20.h),

            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
                fontFamily: "Noto Kufi Arabic",
                color: MyColors.blackColor,
              ),
            ),

            SizedBox(height: 30.h),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // يغلق الديالوج
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.primaryColor,
                      foregroundColor: MyColors.whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: FittedBox(
                      child: Text(
                        "لا",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Noto Kufi Arabic',
                          color: MyColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await context.read<ProfileViewModel>().deleteProfile(context); // ← هنا دالة الحذف

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.whiteColor,
                      foregroundColor: MyColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        side: BorderSide(color: MyColors.primaryColor),
                      ),
                    ),
                    child: FittedBox(
                      child: Text(
                        "نعم",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Noto Kufi Arabic',
                          color: MyColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
