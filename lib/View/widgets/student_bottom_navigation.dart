import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_college/utils/colors.dart';

import '../../Cubits/Home/ChatScreenViewModel.dart';
import '../../services/local/sharedPreference.dart';
import '../../View/Student/Materials&Exams/ExamScreen.dart';
import '../../View/Student/Profile/ProfileScreen.dart';
import '../SmartChat/SmartChat.dart';
import '../Student/subjects.dart';

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
            currentIndex: currentIndex,
            onTap: (index) {
              _handleNavigation(context, index);
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: MyColors.primaryColor,
            unselectedItemColor: MyColors.textColor,
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
                  "assets/images/subject.svg",
                  width: 24.w,
                  height: 24.h,
                  color: currentIndex == 1
                      ? MyColors.primaryColor
                      : MyColors.textColor,
                ),
                label: ' المواد الدراسية',
              ),
              const BottomNavigationBarItem(
                icon: SizedBox.shrink(), // مكان فاضي لزر الشات
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/exam.svg",
                  width: 24.w,
                  height: 24.h,
                  color: currentIndex == 3
                      ? MyColors.primaryColor
                      : MyColors.textColor,
                ),
                label: 'الامتحانات',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/profile.svg",
                  width: 24.w,
                  height: 24.h,
                  color: currentIndex == 4
                      ? MyColors.primaryColor
                      : MyColors.greyColor,
                ),
                label: 'حسابي',
              ),
            ],
          ),
        ),

        // ✅ زر الشات الطالع لفوق (يفتح صفحة Admin Chat)
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

  // ✅ Function للتعامل مع كل الـ Navigation
  void _handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0: // الرئيسية
        onTap(0); // يرجع للصفحة الرئيسية في الـ IndexedStack
        break;

      case 1: // المواد الدراسية
        Navigator.pushNamed(context, Subjects_Screen.routeName);
        break;

      case 2: // مكان فاضي (الشات في النص)
        // مافيش حاجة، لأن الزر الطالع لفوق هيتحكم
        break;

      case 3: // الامتحانات
        Navigator.pushNamed(context, Examscreen.routeName);
        break;

      case 4: // الملف الشخصي
        Navigator.pushNamed(context, ProfileScreen.routeName);
        break;

      default:
        onTap(index);
    }
  }
}