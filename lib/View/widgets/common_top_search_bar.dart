import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_college/utils/colors.dart';

import '../../services/local/sharedPreference.dart';
import '../Notification/notification_screen.dart';
import '../SmartChat/SmartChat.dart';

class CommonTopSearchBar extends StatefulWidget {
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
  State<CommonTopSearchBar> createState() => _CommonTopSearchBarState();
}



class _CommonTopSearchBarState extends State<CommonTopSearchBar> {
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
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => NotificationScreen(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            },
            child: Container(
              width: 39.w,
              height: 38.h,
              decoration: BoxDecoration(
                color: MyColors.whiteColor,
                border: Border.all(
                  color: MyColors.whiteColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(9),
                
                
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
                 color: MyColors.whiteColor,
                  width: 1,
                ),
                
              ),
              child: TextField(
                controller: widget.controller,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    child: Icon(
                      Icons.search,
                      color: MyColors.greyColor,
                    ),
                  ),
                  hintText: widget.hintText,
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
          GestureDetector(
            onTap: () async {
              final savedToken = await TokenStorage.getToken();
              print("Token used: $savedToken");

              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => ChatScreen(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );

            },
            child: Container(
              width: 39.w,
              height: 38.h,
              decoration: BoxDecoration(
                color: MyColors.whiteColor,
                borderRadius: BorderRadius.circular(9),
                border: Border.all(
                  color: MyColors.whiteColor,
                  width: 1,
                ),
               
              ),
              child: Center(
                child: Image.asset(
                  "assets/images/Notification.png",
                  width: 40.w,
                  height: 40.h,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


