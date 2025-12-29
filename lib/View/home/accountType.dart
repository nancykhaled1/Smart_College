import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_college/utils/colors.dart';

import '../../services/local/sharedPreference.dart';
import '../Auth/Register/alumniRegister.dart';
import '../Auth/Register/studentRegister.dart';

class account_type extends StatelessWidget {
   static const String routeName = 'accontType';
  const account_type({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          // هنا بتتحكمى هل ترجعى ولا لا
          return false; // ❌ مش هيرجع
          // return true;  ✅ هيرجع
        },
        child: Scaffold(
          backgroundColor: MyColors.whiteColor,
          body: Column(
            children: [
              // Main content area
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 50.h),
                      Text(
                        "اختر نوع الحساب",
                        style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Noto Kufi Arabic",
                        ),
                      ),
                      SizedBox(height: 40.h),
                      GestureDetector(
                        onTap: () async {
                          // ✅ حفظ الرول
                          await TokenStorage.saveRole("Graduated");

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AlumniRegisterScreen(role: "Graduated"),
                            ),
                          );
                        },
                        child: Container(
                          width: 271.w,
                          height: 143.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: MyColors.primaryColor,
                              width: .5,
                            ),
                            borderRadius: BorderRadius.circular(10),
                             boxShadow: [
                              BoxShadow(
                               color: MyColors.primaryColor.withOpacity(0.3), // شادو ناعم
                            spreadRadius: 1,   // بيكبر الظل شوية لبرا
                            blurRadius: 5,     // يدي نعومة
                            offset: Offset(0, 2), // ينزل لتحت شوية
                              ),
                            ],
                          ),

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                  Image.asset(
                                    "assets/images/grad.png",
                                  ),
                              SizedBox(height: 4.h),
                              Text("خريج",
                                  style: TextStyle(
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Noto Kufi Arabic",
                                  )),
                            ],
                          ),

                        ),
                      ),
                      SizedBox(height: 48.h),
                      GestureDetector(
                        onTap: () async {
                          // ✅ حفظ الرول
                          await TokenStorage.saveRole("Student");

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const StudentRegisterScreen(role: "Student"),
                            ),
                          );
                        },
                        child: Container(
                          width: 271.w,
                          height: 143.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: MyColors.primaryColor,
                              width: .5,
                            ),
                            borderRadius: BorderRadius.circular(10),
                         boxShadow: [
                              BoxShadow(
                               color: MyColors.primaryColor.withOpacity(0.3), // شادو ناعم
                            spreadRadius: 1,   // بيكبر الظل شوية لبرا
                            blurRadius: 5,     // يدي نعومة
                            offset: Offset(0, 2), // ينزل لتحت شوية
                              ),
                            ],

                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/images/student_type.svg",
                              ),
                              SizedBox(height: 4.h),
                              Text("طالب",
                                  style: TextStyle(
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Noto Kufi Arabic",
                                  )),
                            ],
                          ),
                        ),
                      ),
                   //   SizedBox(height: 10.h),
                    ],
                  ),
                ),
              ),
              // Group 250 image at bottom
              Container(
               // height: 225.h,
               // width: double.infinity,
                child: SvgPicture.asset(
                  "assets/images/Group 250.svg",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
