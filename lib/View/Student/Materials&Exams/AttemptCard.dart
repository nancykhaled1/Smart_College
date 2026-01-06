import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:smart_college/Models/Response/MyAttemptsResponse.dart';

import '../../../utils/colors.dart';
import 'QuestionsResult.dart';

class ExamCard extends StatelessWidget {
  final MyAttempts attempt; // ✅ خليه يستقبل attempt بالكامل



  const ExamCard({
    super.key,
    required this.attempt,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime parsedDate =
    DateTime.parse(attempt.updatedAt ?? '').toLocal();
    final String formattedDate = DateFormat(
      'HH:mm – dd/MM/yyyy',
    ).format(parsedDate);
    double progress = 0.0;

    if ((attempt.maxPoints ?? 0) > 0) {
      progress = (attempt.totalPoints ?? 0) / (attempt.maxPoints ?? 1);
    }
    progress = progress.clamp(0.0, 1.0);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: MyColors.whiteColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child:
      Row(
        children: [
          // Icon container
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: MyColors.primaryColor,
              borderRadius: BorderRadius.circular(
                10.r,
              ),
            ),
            child: SvgPicture.asset(
              'assets/images/quiz.svg',
            ),
          ),
          SizedBox(width: 15.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  attempt.exam!.title ?? '',
                  style: TextStyle(
                    fontFamily: 'Noto Kufi Arabic',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: MyColors.softBlackColor,
                  ),

                ),
                SizedBox(height: 6.h),
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontFamily: 'Noto Kufi Arabic',
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: MyColors.greyColor,
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [

                    Expanded(
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 6,
                        borderRadius: BorderRadius.circular(10.r),
                        backgroundColor: MyColors.softGreyColor,
                        valueColor: const AlwaysStoppedAnimation(MyColors.primaryColor),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "${attempt.totalPoints}/${attempt.maxPoints}",
                      style: const TextStyle(color: MyColors.shadowGreyColor, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
              onTap: (){
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => ResultQuestionScreen( attempt: attempt,

                    ),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
              child: Icon(Icons.arrow_forward_ios_rounded, color: MyColors.shadowGreyColor)),






        ],
      ),






    );
  }
}