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
  late Animation<Offset> _splashAnimation;
  late Animation<Offset> _shadowAnimation;

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

  
    _splashAnimation = Tween<Offset>(
      begin: const Offset(0, -2), // Start from top
      end: Offset.zero, // End at center
    ).animate(CurvedAnimation(
      parent: _splashController,
      curve: Curves.easeOutBack,
    ));

    _shadowAnimation = Tween<Offset>(
      begin: const Offset(-2, 0), // Start from left
      end: Offset.zero, // End at center
    ).animate(CurvedAnimation(
      parent: _shadowController,
      curve: Curves.easeOutBack,
    ));

   
    _splashController.forward();
    _shadowController.forward();

    
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Empty space at top
          SizedBox(height: 50.h),
          
        
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
                Text("Smart college",style: TextStyle(color: Color(0xff14B8A6),fontSize: 30.sp,fontWeight: FontWeight.w600, fontFamily: "Noto Kufi Arabic",),)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 50.h),
            child: Center(
              child: SvgPicture.asset("assets/images/Loader.svg"),
            ),
          ),
        ],
      ),
    );
  }
}
