import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../../../utils/colors.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String body;
  final String date;
  final bool read;

  const NotificationCard({
    Key? key,
    required this.title,
    required this.body,
    required this.date,
    required this.read
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // حاولنا نعمل فورمات للتاريخ لو اتبعت صح من الـ API

    final DateTime parsedDate = DateTime.parse(date ).toLocal();
    final String formattedDate = DateFormat('HH:mm – dd/MM/yyyy').format(parsedDate);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: MyColors.shadowGreyColor.withOpacity(0.25),
              blurRadius: 15,
              spreadRadius: 4,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 49.w,
              height: 75.h,
              decoration: BoxDecoration(
                color: read ? MyColors.primaryColor : MyColors.shadowGreyColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15.r),
                  bottomRight: Radius.circular(15.r),
                  topLeft: Radius.circular(15.r),
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/notification2.svg',
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1, // 👈 ياخد سطر واحد بس
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Noto Kufi Arabic',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: MyColors.softBlackColor,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      body,
                      maxLines: 1, // 👈 ياخد سطر واحد بس
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Noto Kufi Arabic',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: MyColors.softBlackColor,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        formattedDate,
                        style: TextStyle(
                          fontFamily: 'Numans',
                          fontWeight: FontWeight.w400,
                          fontSize: 9.sp,
                          color: MyColors.greyColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
