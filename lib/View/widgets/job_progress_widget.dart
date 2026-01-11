import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_college/utils/colors.dart';

class JobProgressCard extends StatelessWidget {
  const JobProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    final jobs = [
      {'title': 'Software Engineer', 'progress': 0.75},
      {'title': 'Data Scientist', 'progress': 0.60},
      {'title': 'Product Manager', 'progress': 0.25},
      {'title': 'Marketing Specialist', 'progress': 0.35},
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: MyColors.whiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // العنوان
            Row(
              children: [
                SvgPicture.asset(
                  'assets/images/suitcase.svg',
                  width: 24.w,
                  height: 24.h,
                  color: Color(0xff14B8A6),
                ),
                SizedBox(width: 8.w),
                Text(
                  "المسمى الوظيفي",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: MyColors.softBlackColor,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Noto Kufi Arabic',
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 20.h),
            
            // قائمة الوظائف - العنوان وشريط التقدم في نفس الصف
            ...jobs.map((job) => Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Row(
                children: [
                  // شريط التقدم
                  Expanded(
                    child: Container(
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerRight,
                        widthFactor: job['progress'] as double,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xff14B8A6),
                                Color(0xff2DD4BF),
                              ],
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(width: 12.w),
                  
                  // عنوان الوظيفة
                  SizedBox(
                    width: 120.w,
                    child: Text(
                      job['title'] as String,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: MyColors.greyColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Noto Kufi Arabic',
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }
}