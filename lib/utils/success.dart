
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_college/View/Auth/Login/login.dart';

import '../../../utils/colors.dart';

class SuccessScreen extends StatelessWidget{
  static const String routeName = 'success';

  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // هنا بتتحكمى هل ترجعى ولا لا
        return false; // ❌ مش هيرجع
        // return true;  ✅ هيرجع
      },
      child: Scaffold(
        backgroundColor: MyColors.whiteColor,
        body: Padding(
          padding:  EdgeInsets.only(top: 40.sp),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/success.svg',

                ),
                SizedBox(
                  height: 50.h,
                ),
                Text('تم انشاء حسابك بنجاح',
                style: TextStyle(
                  color: MyColors.softBlackColor,
                  fontSize: 20.sp,
                  fontFamily: "Noto Kufi Arabic",
                  fontWeight: FontWeight.w400
                ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text('تم تغير كلمة المرور بنجاح بامكانك الان تسجيل الدخول',
                  style: TextStyle(
                      color: MyColors.greyColor,
                      fontSize: 14.sp,
                      fontFamily: "Noto Kufi Arabic",
                      fontWeight: FontWeight.w400
                  ),
                ),
                SizedBox(
                  height: 150.h,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => LoginScreen()),
                    );
                  },
                  child: Text(
                    "تسجيل الدخول",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontFamily: "Noto Kufi Arabic",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.primaryColor,
                    foregroundColor: MyColors.whiteColor,
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 130.w,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}