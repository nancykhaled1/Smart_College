import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_college/utils/colors.dart';
import 'accountType.dart';

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

    // Splash Animation
    _splashController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Shadow Animation
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

    // Navigate after delay
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const account_type()),
        );
      }
    });
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
                        height: 15.h,
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
