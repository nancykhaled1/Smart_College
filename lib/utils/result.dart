import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_college/View/Student/Materials&Exams/ResultScreen.dart';
import 'package:smart_college/View/Student/Profile/ProfileScreen.dart';
import 'package:smart_college/View/Student/Profile/SettingScreen.dart';
import 'package:smart_college/View/home/homeScreen.dart';
import 'colors.dart';

class BuildDialog extends StatelessWidget {
  final String message;
  final String? subMessage;
  final VoidCallback? onDismiss; // دالة اختيارية للتنفيذ عند النقر
  final VoidCallback? result; // دالة اختيارية للتنفيذ عند النقر
  final String? image;
  final Map<String, dynamic>? examData;

  const BuildDialog({
    Key? key,
    required this.message,
    this.subMessage,
    this.onDismiss, // السماح بتمرير دالة تنفيذية عند النقر
    this.result,
    this.image,
    this.examData
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       // Navigator.pop(context); // إغلاق الـ Dialog
        if (onDismiss != null) {
          onDismiss!(); // تنفيذ الدالة إذا تم تمريرها
        }
      },
      child: AlertDialog(
        backgroundColor: MyColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
       // contentPadding: EdgeInsets.only(top: 30.h, bottom: 40.h),
        content: Padding(
          padding: EdgeInsets.symmetric(
           // horizontal: 20.w,
            vertical: 30.h
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                image ??'',

              ),
              SizedBox(height: 40.h),
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
              if (subMessage != null) ...[
                SizedBox(height: 8),
                Text(
                  subMessage!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15.sp, color: Colors.grey[700]),
                ),


              ],
              SizedBox(height: 30.h),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.pushNamed(
                          context,
                          ResultScreen.routeName, // اسم المسار بتاع ResultScreen
                          arguments: examData, // 👈 بنمرر البيانات
                        );

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.primaryColor,
                        foregroundColor: MyColors.whiteColor,
                        // padding: EdgeInsets.symmetric(
                        //   vertical: 6.h,
                        //   horizontal: 25.w,
                        // ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: FittedBox(
                        child: Text("عرض النتيجه",
                          //overflow: TextOverflow.ellipsis,
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
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.pushReplacementNamed(context, HomeScreen.routeName);

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.whiteColor,
                        foregroundColor: MyColors.primaryColor,
                        // padding: EdgeInsets.symmetric(
                        //   vertical: 6.h,
                        //   horizontal: 25.w,
                        // ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            side: BorderSide(
                                color: MyColors.primaryColor
                            )
                        ),
                      ),
                      child: FittedBox(
                        child: Text("خروج",
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
              )
            ],
          ),
        ),
      ),
    );
  }
}









