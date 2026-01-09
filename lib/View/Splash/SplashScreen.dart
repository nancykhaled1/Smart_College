import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_college/View/home/homeScreen.dart';
import '../../services/local/sharedPreference.dart';
import '../../utils/colors.dart';
import '../Graduated/home/graduatedHomeScreen.dart';
import '../Onboarding/onboarding.dart';
import '../home/accountType.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = 'splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
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

    Future.wait([
      _splashController.forward().orCancel,
      _shadowController.forward().orCancel,
    ]).then((_) async {
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        await _checkAuth();
      }
    });
  }

  _checkAuth() async {
    final token = await TokenStorage.getToken();
    final role = await TokenStorage.getRole();
    final savedIsNew = await TokenStorage.getIsNew();

    if (token != null) {
      if (role == "Student") {
        if (savedIsNew == true) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const AccountType()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        }
      } else if (role == "Graduated") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const GraduatedHomeScreen()),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnBoarding()),
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top spacer
              const Spacer(flex: 3),

              // Logo + Shadow + Text - Centered
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SlideTransition(
                    position: _splashAnimation,
                    child: SvgPicture.asset(
                      "assets/images/splash.svg",
                      width: 184.w,
                      height: 122.h,
                      fit: BoxFit.contain,
                    ),
                  ),

                  SizedBox(height: 20.h),

                  SlideTransition(
                    position: _shadowAnimation,
                    child: SvgPicture.asset(
                      "assets/images/SHADO.svg",
                      width: 50.w,
                      height: 7.h,
                      fit: BoxFit.contain,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  Text(
                    "Smart college",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xff14B8A6),
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Noto Kufi Arabic",
                    ),
                  ),
                ],
              ),

              // Bottom spacer
              const Spacer(flex: 3),

              // Loader at bottom - Centered
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
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
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
        ),
      ),
    );
  }
}