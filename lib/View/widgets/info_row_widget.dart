import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_college/utils/colors.dart';

class TrainingCard extends StatelessWidget {
  final String title;
  final String description;
  final String location;
  final String startDate;
  final String endDate;
  final String company;
  final String? iconPath;
  final VoidCallback onApplyPressed;
  final String ? imagePath ;

  const TrainingCard({
    Key? key,
    required this.title,
    required this.description,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.company,
    this.iconPath,
    required this.onApplyPressed, 
     this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 345.w,
      decoration: BoxDecoration(
        color: MyColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
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
          /// ✅ الصورة في الأعلى
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.asset(
              'assets/images/Frame.png',
              width: double.infinity,
              height: 180.h,
              fit: BoxFit.cover,
            ),
          ),

          /// ✅ المحتوى تحت الصورة
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// العنوان والوصف
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// الأيقونة (اختيارية)
                    if (iconPath != null) ...[
                      SvgPicture.asset(
                        iconPath!,
                        width: 60.w,
                        height: 60.h,
                      ),
                     // SizedBox(width: 10.w),
                    ],

                    /// النصوص
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontFamily: "Noto Kufi Arabic",
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: MyColors.blackColor,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            description,
                            style: TextStyle(
                              fontFamily: "Noto Kufi Arabic",
                              fontWeight: FontWeight.w500,
                              fontSize: 10.sp,
                              color: MyColors.textColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 15.h),

                /// باقي التفاصيل
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(
                      'assets/images/location.svg',
                      location,
                    ),
                    SizedBox(height: 10.h),
                    _buildInfoRow(
                      'assets/images/calendar.svg',
                      "$startDate – $endDate",
                    ),
                    SizedBox(height: 10.h),
                    _buildInfoRow(
                      'assets/images/building.svg',
                      company,
                    ),
                    SizedBox(height: 10.h),
                    _buildInfoRow(
                      'assets/images/map.svg',
                      "View in Map",
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                /// زر التقديم
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: onApplyPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 60.w,
                        vertical: 12.h,
                      ),
                    ),
                    child: Text(
                      "قدم الآن",
                      style: TextStyle(
                        fontFamily: "Noto Kufi Arabic",
                        fontWeight: FontWeight.w700,
                        fontSize: 15.sp,
                        color: MyColors.whiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String iconPath, String text) {
    return Row(
      children: [
        SvgPicture.asset(
          iconPath,
          width: 16.w,
          height: 16.h,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: "Noto Kufi Arabic",
              fontWeight: FontWeight.w500,
              fontSize: 10.sp,
              color: MyColors.greyColor,
            ),
          ),
        ),
      ],
    );
  }
}