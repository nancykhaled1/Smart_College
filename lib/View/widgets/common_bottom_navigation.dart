import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_college/utils/colors.dart';

class CommonBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CommonBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: MyColors.primaryColor,
        unselectedItemColor: MyColors.greyColor,
        selectedLabelStyle: TextStyle(
          fontFamily: "Noto Kufi Arabic",
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: "Noto Kufi Arabic",
          fontSize: 10.sp,
          fontWeight: FontWeight.w400,
        ),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/images/home.svg",
              width: 24.w,
              height: 24.h,
              color: currentIndex == 0 ? MyColors.primaryColor : MyColors.greyColor,
            ),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/images/studies.svg",
              width: 24.w,
              height: 24.h,
              color: currentIndex == 1 ? MyColors.primaryColor : MyColors.greyColor,
            ),
            label: 'دراسات عليا ',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/images/icon.svg",
              width: 24.w,
              height: 24.h,
              color: currentIndex == 2 ? MyColors.primaryColor : MyColors.greyColor,
            ),
            label: 'تدريبات',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/images/dashboard.svg",
              width: 24.w,
              height: 24.h,
              color: currentIndex == 3 ? MyColors.primaryColor : MyColors.greyColor,
            ),
            label: ' dashboard',
          ),
          // BottomNavigationBarItem(
          //   icon: SvgPicture.asset(
          //     "assets/images/user.svg",
          //     width: 24.w,
          //     height: 24.h,
          //     color: currentIndex == 4 ? MyColors.primaryColor : MyColors.greyColor,
          //   ),
          //   label: 'الملف الشخصي',
          // ),
        ],
      ),
    );
  }
}


