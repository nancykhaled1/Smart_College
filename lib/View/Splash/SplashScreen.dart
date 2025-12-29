import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_college/View/home/homeScreen.dart';
import '../../services/local/sharedPreference.dart';
import '../../utils/colors.dart';
import '../Graduated/home/graduatedHomeScreen.dart';
import '../Onboarding/onboarding.dart';
import '../home/accountType.dart';

class splashScreen extends StatefulWidget {
  static const String routeName = 'splash';
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen>
    with TickerProviderStateMixin {
  late AnimationController _splashController;
  late AnimationController _shadowController;
  late AnimationController _loaderController;
  late Animation<Offset> _splashAnimation;
  late Animation<Offset> _shadowAnimation;
  late Animation<Alignment> _loaderAnimation;


  @override
  void initState() {
    super.initState();


    _splashController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _shadowController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Loader Animation (يمين وشمال)
    _loaderController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _splashAnimation = Tween<Offset>(
      begin: const Offset(0, -2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _splashController,
      curve: Curves.easeOutBack,
    ));

    _shadowAnimation = Tween<Offset>(
      begin: const Offset(-2, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _shadowController,
      curve: Curves.easeOutBack,
    ));

    _loaderAnimation = Tween<Alignment>(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(CurvedAnimation(
      parent: _loaderController,
      curve: Curves.easeInOut,
    ));

    _splashController.forward();
    _shadowController.forward();

    // استنى لحد ما الاتنين يخلصوا
    Future.wait([
      _splashController.forward().orCancel,
      _shadowController.forward().orCancel,
    ]).then((_) async {
      await Future.delayed(const Duration(milliseconds: 500)); // زيادة وقت لو عايزة
      if (mounted) {
        await _checkAuth();
      }
    });


    // Future.delayed(const Duration(seconds: 5), () {
    //   if (mounted) {
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(builder: (context) => const account_type()),
    //     );
    //   }
    // });
  }

  _checkAuth() async {
    final token = await TokenStorage.getToken();
    final role = await TokenStorage.getRole();
    final savedIsNew = await TokenStorage.getIsNew();

    if (token != null) {
      if (role == "Student") {
        if (savedIsNew == true) {
          // 🟢 أول مرة → روح على تكملة البيانات
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => account_type()),
          );
        } else {
          // 🟢 مش أول مرة → روح على الهوم
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomeScreen()),
          );
        }
      } else if (role == "Graduated") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => GraduatedHomeScreen()),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => OnBoarding()),
      );
    }
  }

  @override
  void dispose() {
    _splashController.dispose();
    _shadowController.dispose();
    _loaderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 50.h),

          // Logo + Shadow
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SlideTransition(
                  position: _splashAnimation,
                  child: SvgPicture.asset(
                    "assets/images/SPLASH.svg",
                    width: 184.w,
                    height: 122.h,
                  ),
                ),

                SizedBox(height: 20.h),


                SlideTransition(
                  position: _shadowAnimation,
                  child: SvgPicture.asset(
                    "assets/images/SHADO.svg",
                    width: 50.w,
                    height: 7.h,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Smart college",
                  style: TextStyle(
                    color: const Color(0xff14B8A6),
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Noto Kufi Arabic",
                  ),
                )
              ],
            ),
          ),

          // Loader at bottom
          Padding(
            padding: EdgeInsets.only(bottom: 50.h),
            child: Center(
              child: Container(
                width: 100.w,
                height: 29.h,
                decoration: BoxDecoration(
                  color: MyColors.primaryColor,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: AnimatedBuilder(
                  animation: _loaderAnimation,
                  builder: (context, child) {
                    return Align(
                      alignment: _loaderAnimation.value,
                      child: Container(
                        width: 30.w,
                        height: 10.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
