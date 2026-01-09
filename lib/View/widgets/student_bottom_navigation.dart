import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_college/utils/colors.dart';
import '../../Cubits/Home/ChatScreenViewModel.dart';
import '../../services/local/sharedPreference.dart';
import '../SmartChat/SmartChat.dart';

class StudentBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const StudentBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
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
            currentIndex: currentIndex > 2 ? currentIndex : currentIndex,
            onTap: (index) {
              // ✅ بدل ما نعمل Navigator.push، نبلّغ الـ parent يغير الصفحة
              if (index == 2) {
                // زر الشات - مش هنعمل حاجة هنا
                return;
              }
              onTap(index); // ✅ نبلّغ الـ parent يغير الـ index
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: MyColors.primaryColor,
            unselectedItemColor: MyColors.textColor,
            showSelectedLabels: true,
            showUnselectedLabels: true,
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
              _buildNavItem(
                iconPath: "assets/images/home.svg",
                label: "الرئيسية",
                index: 0,
              ),
              _buildNavItem(
                iconPath: "assets/images/subject.svg",
                label: "المواد الدراسية",
                index: 1,
              ),
              const BottomNavigationBarItem(
                icon: SizedBox.shrink(),
                label: '',
              ),
              _buildNavItem(
                iconPath: "assets/images/exam.svg",
                label: "الامتحانات",
                index: 3,
              ),
              _buildNavItem(
                iconPath: "assets/images/profile.svg",
                label: "حسابي",
                index: 4,
              ),
            ],
          ),
        ),

        // ✅ زر الشات الطالع لفوق
        Positioned(
          top: -25,
          left: MediaQuery.of(context).size.width / 2 - 30,
          child: GestureDetector(
            onTap: () => _openChatScreen(context),
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

  BottomNavigationBarItem _buildNavItem({
    required String iconPath,
    required String label,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        iconPath,
        width: 24.w,
        height: 24.h,
        color: currentIndex == index ? MyColors.primaryColor : MyColors.textColor,
      ),
      label: label,
    );
  }

  Future<void> _openChatScreen(BuildContext context) async {
    final savedToken = await TokenStorage.getToken();
    
    if (!context.mounted) return;

    // ✅ فتح صفحة الشات في صفحة جديدة (مش جزء من الـ bottom navigation)
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => ChatCubit(
            token: savedToken ?? '',
            adminId: "68d505b6cb5768439463619b",
          )..connectSocket(),
          child: const ChatScreen(),
        ),
      ),
    );
  }
}