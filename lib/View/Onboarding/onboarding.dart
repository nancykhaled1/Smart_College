import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_college/View/Auth/Login/login.dart';

import '../../utils/colors.dart';
import '../Auth/Register/roleselection.dart';
import '../home/accountType.dart';


class OnBoarding extends StatefulWidget {
  static const String routeName = 'OnBoarding';
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnBoardingDate> onboarding = [
    OnBoardingDate(
        title: "خليك على اطلاع",
        description: "احدث أخبار الكلية دايمًا عندك و في مكان واحد",
        image: "assets/images/onboarding1.svg"
    ),
    OnBoardingDate(
        title: "جدولك في ايدك",
        description: "اعرف مواعيد محاضراتك وامتحاناتك بسهولة في أي وقت",
        image: "assets/images/onboarding2.svg"),
    OnBoardingDate(
        title: "سجل إنجازاتك",
        description: "عرض خبراتك وشهاداتك في مكان واحد",
        image: "assets/images/onboarding3.svg")
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.whiteColor,
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboarding.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  // شرط تغيير مكان النص فقط في أول صفحة
                  if (index == 0) {
                    return Stack(
                      children: [
                        SvgPicture.asset(
                          onboarding[index].image,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),

                        // 🔹 السهم في أول صفحة: فوق الرسمة على اليمين
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 15.h,
                          child: Padding(
                            padding: EdgeInsets.symmetric( horizontal: 20.w),
                            child: bottomPageView(),
                          ),
                        ),

                        Positioned(
                          top: 120.h, // النص أسفل السهم شوية
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  onboarding[index].title,
                                  style: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Noto Kufi Arabic",
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 15.h),
                                Text(
                                  onboarding[index].description,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Noto Kufi Arabic",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  else {
                    // باقي الصفحات: الصورة تحت النص
                    return Stack(
                      children: [
                        SvgPicture.asset(
                          onboarding[index].image,
                          width: double.infinity,
                          height: double.infinity, // قللنا الارتفاع
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          bottom : 0.h,
                          left: 0.w,
                          right: 0.w,
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // SizedBox(height: 30.h),
                                Text(
                                  onboarding[index].title,
                                  style: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Noto Kufi Arabic",
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  onboarding[index].description,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Noto Kufi Arabic",
                                  ),
                                ),
                                SizedBox(height: 35.h),
                                bottomPageView(),

                              ],
                            ),
                          ),
                        ),

                      ],
                    );


                  }
                },
              ),
            ),
            // المؤشر وزرار التالي
            // bottomPageView(),
          ],
        ),
      ),
    );
  }



  Widget bottomPageView() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 5.w),
      child: _currentIndex == onboarding.length - 1
          ? // 🔹 الصفحة الأخيرة: زر "ابدأ" في النص
      Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => account_type()),
            );
          },
          child: Container(
            width: 130.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: MyColors.primaryColor,
              borderRadius: BorderRadius.circular(15.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 15.r,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Center(
              child: Text(
                "ابدأ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Noto Kufi Arabic",
                ),
              ),
            ),
          ),
        ),
      )
          : // 🔹 الصفحتين الأولى والثانية: سهم يمين + تخطي شمال
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 🔹 تخطي على الشمال

          // 🔹 السهم على اليمين
          GestureDetector(
            onTap: () {
              _pageController.animateToPage(
                _currentIndex + 1,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: _currentIndex == 0
                    ? MyColors.whiteColor
                    : MyColors.primaryColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Transform(
                transform: Matrix4.identity()..scale(-1.0, 1.0),
                alignment: Alignment.center,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: _currentIndex == 0
                      ? MyColors.primaryColor
                      : MyColors.whiteColor,
                  size: 20.sp,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(
                  context, account_type.routeName);
            },
            child: Text(
              "تخطي",
              style: TextStyle(
                color: MyColors.greyColor,
                fontSize: 12.sp,
                fontFamily: "Noto Kufi Arabic",
                fontWeight: FontWeight.w300,
                decoration: TextDecoration.underline,
                decorationColor: MyColors.greyColor,
              ),
            ),
          ),

        ],
      ),
    );
  }


}

class OnBoardingDate {
  final String title;
  final String description;
  final String image;

  OnBoardingDate({
    required this.title,
    required this.description,
    required this.image,
  });
}