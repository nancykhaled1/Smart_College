import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:smart_college/View/home/homeScreen.dart';
import 'package:smart_college/utils/colors.dart';

class ResultScreen extends StatelessWidget{
  static const String routeName = 'result';



  @override
  Widget build(BuildContext context) {
    final examData = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final examTitle = examData["examTitle"];
    final correct = examData["correct"];
    final wrong = examData["wrong"];
    final total = examData["total"];
    final maxPoints = examData["maxPoints"];
    print(maxPoints);

    double percent = total / maxPoints;
    int percentValue = (percent * 100).round();
    return SafeArea(
        child: Scaffold(
          backgroundColor: MyColors.backgroundColor,
          body: Container(
            margin: EdgeInsets.all(20.r),
          //  padding: EdgeInsets.all(15.r),
            decoration: BoxDecoration(
              color: MyColors.whiteColor,
              borderRadius: BorderRadius.circular(
                10.r,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // 👈 ده اللي يخلي الكونتينر يلف حوالين الشيلد
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Positioned(
                      top:0,
                      right: 0,
                      child: Image.asset(
                        'assets/images/Mask group.png',
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 15.h,
                        top: 30.h,
                        left: 15.w,
                        right: 15.w,
                      ),
                      child: Column(
                        children: [
                          Center(
                            child: Text(examTitle ?? '',
                              style: TextStyle(
                                fontFamily: 'Noto Kufi Arabic',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: MyColors.softBlackColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h),
                          Center(
                            child: CircularPercentIndicator(
                              radius: 80.r,
                              lineWidth: 12.w,
                              percent: percent,
                              center: Text(
                                "$percentValue%" ,
                                style: TextStyle(
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.w500,
                                  color: MyColors.blackColor,
                                  fontFamily: 'Rubik',
                                ),
                              ),
                              linearGradient: LinearGradient(
                                colors: [
                                  MyColors.primaryColor,
                                  MyColors.darkGreenColor,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),

                              backgroundColor: MyColors.softGreyColor,
                              circularStrokeCap: CircularStrokeCap.round,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
               // SizedBox(height: 20.h),

                Padding(
                  padding: EdgeInsets.all(15.r),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/images/badge.svg"),
                      SizedBox(width: 3.w),
                      Text("$total/$maxPoints",
                          style: TextStyle(color: MyColors.resultColor)),
                      SizedBox(width: 10.w),
                      SvgPicture.asset("assets/images/checkbox-checked.svg"),
                      SizedBox(width: 3.w),
                      Text("$correct إجابات صحيحة",
                          style: TextStyle(color: MyColors.resultColor)),
                      SizedBox(width: 10.w),
                      SvgPicture.asset("assets/images/close-square.svg"),
                      SizedBox(width: 3.w),
                      Text("$wrong إجابات خاطئة",
                          style: TextStyle(color: MyColors.resultColor)),


                    ],
                  ),
                ),
               // SizedBox(height: 30.h),

                Padding(
                  padding: EdgeInsets.only(
                    bottom: 30.h,
                    top: 15.h,
                    left: 15.w,
                    right: 15.w,
                  ),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.primaryColor,
                        foregroundColor: MyColors.whiteColor,
                        padding: EdgeInsets.symmetric(
                          vertical: 10.h,
                          horizontal: 85.w,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        "العودة للرئيسية",
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontFamily: "Noto Kufi Arabic",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),

    ));
  }

}