// import 'package:flutter/material.dart';
// import 'package:smart_college/View/Auth/Register/studentRegister.dart';
// import 'package:smart_college/View/Auth/Register/alumniRegister.dart';
// import '../../../services/local/sharedPreference.dart'; // ✅ import كلاس التخزين
//
// class RoleSelectionScreen extends StatelessWidget {
//   const RoleSelectionScreen({super.key});
//   static const String routeName = 'role';
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         return false; // ❌ مش هيرجع
//       },
//       child: Scaffold(
//         body: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   "اختر نوع الحساب",
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: "Noto Kufi Arabic",
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//
//                 // زر الطالب
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: const Size(double.infinity, 50),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   onPressed: () async {
//                     // ✅ حفظ الرول
//                     await TokenStorage.saveRole("Student");
//
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => const StudentRegisterScreen(role: "Student"),
//                       ),
//                     );
//                   },
//                   child: const Text("طالب"),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 // زر الخريج
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     minimumSize: const Size(double.infinity, 50),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   onPressed: () async {
//                     // ✅ حفظ الرول
//                     await TokenStorage.saveRole("Graduated");
//
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => const AlumniRegisterScreen(role: "Graduated"),
//                       ),
//                     );
//                   },
//                   child: const Text("خريج"),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_college/View/Auth/Register/studentRegister.dart';
import 'package:smart_college/utils/colors.dart';

import '../../../services/local/sharedPreference.dart';
import 'alumniRegister.dart';

class AccountType extends StatelessWidget {
  static const String routeName = 'accontType';
  const AccountType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Main content area
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 40.h),
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
                              color: MyColors.backgroundColor,
                              width: .5,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset(
                            "assets/images/grad.png",
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
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
                              color: MyColors.backgroundColor,
                              width: .5,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SvgPicture.asset(
                            "assets/images/student.svg",
                          ),
                        ),
                      ),
                      //   SizedBox(height: 10.h),
                    ],
                  ),
                ),
              ),
            ),
            // Group 250 image at bottom
            Container(
              height: 225.h,
              // width: double.infinity,
              child: SvgPicture.asset(
                "assets/images/Group 250.svg",
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
