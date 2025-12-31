import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_college/utils/colors.dart';

import '../../Cubits/Home/ChatScreenViewModel.dart';
import '../../Repositories/ChatRepository.dart';
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
            currentIndex: currentIndex,
            onTap: onTap,
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

        // زر الشات الطالع لفوق
        Positioned(
          top: -25, // يخليه يطلع فوق شوية
          left: MediaQuery.of(context).size.width / 2 - 30, // يتوسط الشاشة
          child: GestureDetector(
            onTap: () async{
              onTap(0);

                final savedToken = await TokenStorage.getToken();
                print("Token used: $savedToken");



              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) => ChatCubit(
                      token: savedToken!, // 🔑 توكن اليوزر الحالي
                      adminId: "68d505b6cb5768439463619b", // الأدمن الأساسي
                    )..connectSocket(), // ⬅️ نبدأ الاتصال فورًا
                    child: ChatScreen(),
                  ),
                ),
              );





            }, // الزر هيعتبر index = 2
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
