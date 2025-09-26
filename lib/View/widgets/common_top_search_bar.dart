import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_college/utils/colors.dart';

class CommonTopSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final VoidCallback? onMenuTap;
  final VoidCallback? onNotificationTap;

  const CommonTopSearchBar({
    super.key,
    this.controller,
    this.hintText = 'ادخل كلمة البحث',
    this.onMenuTap,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 50.h,
        left: 25.w,
        right: 25.w,
        bottom: 20.h,
      ),
      decoration: BoxDecoration(
        color: Color(0xffF5F5F5),
      ),
      child: Row(
        children: [
          // أيقونة القائمة
          Container(
            width: 39.w,
            height: 38.h,
            decoration: BoxDecoration(
              color: MyColors.whiteColor,
              borderRadius: BorderRadius.circular(9),
              border: Border.all(
              //  color: MyColors.greyColor.withOpacity(0.2),
                width: 1,
              ),
              boxShadow: [
                  BoxShadow(
                    color: MyColors.blackColor.withOpacity(0.15),
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: Offset(0, 2),
                  ),
                ],
            ),
            child: Center(
              child: SvgPicture.asset(
                "assets/images/Vector (1).svg",
                width: 20.w,
                height: 20.h,
                fit: BoxFit.contain,
              ),
            ),
          ),
          
          // شريط البحث
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              height: 40.sp,
              decoration: BoxDecoration(
                color: MyColors.whiteColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: MyColors.greyColor.withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: MyColors.blackColor.withOpacity(0.15),
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: controller,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    child: Icon(
                      Icons.search,
                      color: MyColors.greyColor,
                    ),
                  ),
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: MyColors.greyColor,
                    fontFamily: "Noto Kufi Arabic",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 5, bottom: 18),
                ),
              ),
            ),
          ),
          
          // أيقونة الإشعارات
          Container(
            width: 39.w,
            height: 38.h,
            decoration: BoxDecoration(
              color: MyColors.whiteColor,
              borderRadius: BorderRadius.circular(9),
              border: Border.all(
                color: MyColors.greyColor.withOpacity(0.2),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: MyColors.blackColor.withOpacity(0.1),
                  blurRadius: 3,
                  spreadRadius: 1,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Center(
              child: SvgPicture.asset(
                "assets/images/Notification.svg",
                width: 20.w,
                height: 20.h,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


