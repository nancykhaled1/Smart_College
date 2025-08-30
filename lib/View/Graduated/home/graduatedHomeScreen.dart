import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:smart_college/utils/colors.dart';

class GraduatedHomeScreen extends StatelessWidget {
  static const String routeName = 'gradhome';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // هنا بتتحكمى هل ترجعى ولا لا
        return false; // ❌ مش هيرجع
        // return true;  ✅ هيرجع
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
               // height: 200,
               // width: 400,
                decoration: BoxDecoration(
                  color: MyColors.whiteColor,
                  border: Border.all(color: Colors.blue, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset('assets/images/graduation-cap.svg'),
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          "الخريجين",
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: MyColors.blackColor,
                              fontWeight: FontWeight.w500 ,
                              fontFamily: 'Noto Kufi Arabic'),
                        ),
                        Spacer(),
                        SvgPicture.asset('assets/images/Rectangle.svg'),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCircle("30%", "دراسات عليا", 0.3,
                            [MyColors.pnkcolor , MyColors.pnkcolor2]
                        ),
                        _buildCircle("66%", "عامل حر", 0.66, [MyColors.pnkcolor , MyColors.pnkcolor2]),
                        _buildCircle("85%", "موظف", 0.85, [MyColors.pnkcolor , MyColors.pnkcolor2]),
                        _buildCircle("90%", "باحث عن عمل", 0.9, [MyColors.pnkcolor , MyColors.pnkcolor2]),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      "عرض المزيد",
                      style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),

            ],
          ),

        ),
      ),
    );
  }

  Widget _buildCircle(String percentText, String label, double percent, List<Color> gradientColors) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 40.0,
          lineWidth: 6.0,
          percent: percent,
          center: Text(
            percentText,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          linearGradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          backgroundColor: Colors.grey.shade300,
          circularStrokeCap: CircularStrokeCap.round,
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }

}
