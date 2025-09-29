// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:smart_college/View/Auth/Register/roleselection.dart';
// import 'package:smart_college/View/Auth/Register/studentRegister.dart';
// import 'package:smart_college/View/Onboarding/onboarding.dart';
// import '../../services/local/sharedPreference.dart';
// import '../Auth/Register/CompleteStudentProfile.dart';
// import '../Graduated/home/graduatedHomeScreen.dart';
// import '../Student/Home/StudentHomeScreen.dart';
//
// class SplashScreen extends StatefulWidget {
//   static const String routeName = 'splash';
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _splashController;
//   late AnimationController _shadowController;
//   late Animation<Offset> _splashAnimation;
//   late Animation<Offset> _shadowAnimation;
//
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _checkAuth();
//   //
//   //
//   //   _splashController = AnimationController(
//   //     duration: const Duration(milliseconds: 1500),
//   //     vsync: this,
//   //   );
//   //
//   //   _shadowController = AnimationController(
//   //     duration: const Duration(milliseconds: 1500),
//   //     vsync: this,
//   //   );
//   //
//   //
//   //   _splashAnimation = Tween<Offset>(
//   //     begin: const Offset(0, -2), // Start from top
//   //     end: Offset.zero, // End at center
//   //   ).animate(CurvedAnimation(
//   //     parent: _splashController,
//   //     curve: Curves.easeOutBack,
//   //   ));
//   //
//   //   _shadowAnimation = Tween<Offset>(
//   //     begin: const Offset(-2, 0), // Start from left
//   //     end: Offset.zero, // End at center
//   //   ).animate(CurvedAnimation(
//   //     parent: _shadowController,
//   //     curve: Curves.easeOutBack,
//   //   ));
//   //
//   //
//   //   _splashController.forward();
//   //   _shadowController.forward();
//   //
//   //
//   //   Future.delayed(const Duration(milliseconds: 1000), () {
//   //     if (mounted) {
//   //       Navigator.pushReplacement(
//   //         context,
//   //         MaterialPageRoute(builder: (context) => const AccountType()),
//   //       );
//   //     }
//   //   });
//   // }
//
//   @override
//   void initState() {
//     super.initState();
//
//     _splashController = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     );
//
//     _shadowController = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     );
//
//     _splashAnimation = Tween<Offset>(
//       begin: const Offset(0, -2),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _splashController,
//       curve: Curves.easeOutBack,
//     ));
//
//     _shadowAnimation = Tween<Offset>(
//       begin: const Offset(-2, 0),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _shadowController,
//       curve: Curves.easeOutBack,
//     ));
//
//     _splashController.forward();
//     _shadowController.forward();
//
//     // استنى لحد ما الاتنين يخلصوا
//     Future.wait([
//       _splashController.forward().orCancel,
//       _shadowController.forward().orCancel,
//     ]).then((_) async {
//       await Future.delayed(const Duration(milliseconds: 500)); // زيادة وقت لو عايزة
//       if (mounted) {
//         await _checkAuth();
//       }
//     });
//   }
//
//
//
//   _checkAuth() async {
//     final token = await TokenStorage.getToken();
//     final role = await TokenStorage.getRole();
//     final savedIsNew = await TokenStorage.getIsNew();
//
//     if (token != null) {
//       if (role == "Student") {
//         if (savedIsNew == true) {
//           // 🟢 أول مرة → روح على تكملة البيانات
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (_) => AccountType()),
//           );
//         } else {
//           // 🟢 مش أول مرة → روح على الهوم
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (_) => StudentHomeScreen()),
//           );
//         }
//       } else if (role == "Graduated") {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => GraduatedHomeScreen()),
//         );
//       }
//     } else {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => OnBoarding()),
//       );
//     }
//   }
//
//
//   @override
//   void dispose() {
//     _splashController.dispose();
//     _shadowController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // Empty space at top
//           SizedBox(height: 50.h),
//
//
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//
//                 SlideTransition(
//                   position: _splashAnimation,
//                   child: SvgPicture.asset(
//                     "assets/images/splash.svg",
//                     width: 184.w,
//                     height: 122.h,
//                   ),
//                 ),
//
//                 SizedBox(height: 20.h),
//
//
//                 SlideTransition(
//                   position: _shadowAnimation,
//                   child: SvgPicture.asset(
//                     "assets/images/shadow.svg",
//                     width: 50.w,
//                     height: 7.h,
//                   ),
//                 ),
//                 SizedBox(height: 8.h),
//                 Text("Smart college",style: TextStyle(color: Color(0xff14B8A6),fontSize: 30.sp,fontWeight: FontWeight.w600, fontFamily: "Noto Kufi Arabic",),)
//               ],
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(bottom: 50.h),
//             child: Center(
//               child: SvgPicture.asset("assets/images/Loader.svg"),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }