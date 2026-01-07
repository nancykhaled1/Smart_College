import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_college/Cubits/Home/ChatScreenViewModel.dart';
import 'package:smart_college/View/Graduated/home/dashboard.dart';
import 'package:smart_college/View/Graduated/home/postgraduat_%20studies.dart';
import 'package:smart_college/View/Graduated/home/training.dart';
import 'package:smart_college/View/SmartChat/SmartChat.dart';
import 'package:smart_college/services/local/sharedPreference.dart';
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
        onTap: (index) {
          onTap(index);
        },
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
          top: -25,
          left: MediaQuery.of(context).size.width / 2 - 30,
          child: GestureDetector(
            onTap: () async {
              final savedToken = await TokenStorage.getToken();
              print("Token used: $savedToken");

              // ✅ نروح لصفحة الشات بدون ما نأثر على الـ navigation
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) => ChatCubit(
                      token: savedToken ?? '', // 🔑 توكن اليوزر الحالي
                      adminId: "68d505b6cb5768439463619b", // الأدمن الأساسي
                    )..connectSocket(), // ⬅️ نبدأ الاتصال فورًا
                    child: ChatScreen(),
                  ),
                ),
              );
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: MyColors.primaryColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: MyColors.primaryColor.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: SvgPicture.asset(
                  "assets/images/chat.svg",
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
 void _handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        onTap(0); 
        break;

      case 1: 
        Navigator.pushNamed(context, PostgraduatStudies.routeName);
        break;


      case 3: 
        Navigator.pushNamed(context, TrainingPage.routeName);
        break;

      case 4: 
        Navigator.pushNamed(context, DashboardPage.routeName);
        break;

      default:
        onTap(index);
    }
  } 
}
