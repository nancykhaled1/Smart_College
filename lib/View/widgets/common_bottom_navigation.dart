import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_college/utils/colors.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Bottom Navigation
        Container(
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
                  color: currentIndex == 0
                      ? MyColors.primaryColor
                      : MyColors.textColor,
                ),
                label: 'الرئيسية',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/studies.svg",
                  width: 24.w,
                  height: 24.h,
                  color: currentIndex == 1
                      ? MyColors.primaryColor
                      : MyColors.textColor,
                ),
                label: 'دراسات عليا',
              ),
              const BottomNavigationBarItem(
                icon: SizedBox.shrink(), // مكان فاضي لزر الشات
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/icon.svg",
                  width: 24.w,
                  height: 24.h,
                  color: currentIndex == 3
                      ? MyColors.primaryColor
                      : MyColors.textColor,
                ),
                label: 'تدريبات',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/dashboard.svg",
                  width: 24.w,
                  height: 24.h,
                  color: currentIndex == 4
                      ? MyColors.primaryColor
                      : MyColors.textColor,
                ),
                label: 'Dashboard',
              ),
            ],
          ),
        ),

        // زر الشات الطالع لفوق
        Positioned(
          top: -25, // يخليه يطلع فوق شوية
          left: MediaQuery.of(context).size.width / 2 - 30, // يتوسط الشاشة
          child: GestureDetector(
            onTap: () => onTap(0), // الزر هيعتبر index = 2
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: MyColors.primaryColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  "assets/images/chat.svg", // أيقونة الشات
                  width: 28.w,
                  height: 28.h,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
