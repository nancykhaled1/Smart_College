import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_college/utils/colors.dart';

import '../../services/local/sharedPreference.dart';
import '../Auth/Register/alumniRegister.dart';
import '../Auth/Register/studentRegister.dart';

class AccountType extends StatelessWidget {
  static const String routeName = 'accountType';
  const AccountType({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: MyColors.whiteColor,
        body: SafeArea(
          child: Column(
            children: [
              // Main content area
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        SizedBox(height: 60.h),
                        Text(
                          "اختر نوع الحساب",
                          style: TextStyle(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Noto Kufi Arabic",
                          ),
                        ),
                        SizedBox(height: 50.h),
                        
                       
                        _buildAccountTypeCard(
                          context: context,
                          title: "خريج",
                          imagePath: "assets/images/grad.png",
                          isAsset: true,
                          onTap: () async {
                            await TokenStorage.saveRole("Graduated");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AlumniRegisterScreen(role: "Graduated"),
                              ),
                            );
                          },
                        ),
                        
                        SizedBox(height: 30.h),
                        
                        // طالب Card
                        _buildAccountTypeCard(
                          context: context,
                          title: "طالب",
                          imagePath: "assets/images/student_type.svg",
                          isAsset: false,
                          onTap: () async {
                            await TokenStorage.saveRole("Student");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const StudentRegisterScreen(role: "Student"),
                              ),
                            );
                          },
                        ),
                        
                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                ),
              ),
              
              // Bottom decoration image
              SvgPicture.asset(
                "assets/images/Group 250.svg",
                fit: BoxFit.fitWidth,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountTypeCard({
    required BuildContext context,
    required String title,
    required String imagePath,
    required bool isAsset,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          maxWidth: 320.w,
          minHeight: 140.h,
        ),
        padding: EdgeInsets.symmetric(vertical: 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: MyColors.primaryColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: MyColors.primaryColor.withOpacity(0.15),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 60.h,
              child: isAsset
                  ? Image.asset(
                      imagePath,
                      fit: BoxFit.contain,
                    )
                  : SvgPicture.asset(
                      imagePath,
                      fit: BoxFit.contain,
                    ),
            ),
            SizedBox(height: 12.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w500,
                fontFamily: "Noto Kufi Arabic",
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}