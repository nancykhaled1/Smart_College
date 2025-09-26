import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_college/Models/Response/news_model.dart';
import 'package:smart_college/utils/colors.dart';
import 'package:smart_college/services/news_service.dart';
import 'package:smart_college/View/Student/news_details.dart';

class AllNews extends StatelessWidget {
  AllNews({super.key});
  
  // الحصول على جميع الأخبار من الخدمة
  List<NewsModel> get newsItems => NewsService.getAllNews();


  // قائمة بأسماء الشهور باللغة العربية
  final List<String> _months = [
    'يناير',
    'فبراير',
    'مارس',
    'أبريل',
    'مايو',
    'يونيو',
    'يوليو',
    'أغسطس',
    'سبتمبر',
    'أكتوبر',
    'نوفمبر',
    'ديسمبر',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // الخلفية
          Positioned.fill(
            child: SvgPicture.asset(
              "assets/images/Background.svg", 
              fit: BoxFit.cover,
            ),
          ),
          
          // العنوان والكونتينر في أعلى الصفحة
          Positioned(
            top: 50.h,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // كونتينر صورة الرجوع
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 39.w,
                      height: 38.h,
                      decoration: BoxDecoration(
                        color: MyColors.whiteColor,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/images/back.svg",
                          width: 8.w,
                          height: 13.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  
                  // نص العنوان
                  Text(
                    "الأخبار",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Noto Kufi Arabic",
                      color: MyColors.blackColor,
                    ),
                  ),
                  
                  // مساحة فارغة للتوازن
                  SizedBox(width: 39.w),
                ],
              ),
            ),
          ),
          
          // قائمة الأخبار
          Positioned(
            top: 90.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: ListView.builder(
                itemCount: newsItems.length,
                itemBuilder: (context, index) {
                  final news = newsItems[index];
                  return Card(
                    margin: EdgeInsets.only(bottom: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      color: MyColors.whiteColor,
                      width: 350.w,
                      height: 100.h,
                      child: Row(
                        children: [
                          Expanded(
                            child: Image.asset(
                              news.mainImage,
                              width: 120.w,
                              height: 100.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 12),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  news.title,
                                  style: TextStyle(
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Noto Kufi Arabic",
                                    color: MyColors.blackColor,
                                  ),
                                  maxLines: 2,
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    news.createdAt != null 
                                        ? "${news.createdAt!.day} ${_months[news.createdAt!.month - 1]}, ${news.createdAt!.year}"
                                        : "17 أكتوبر, 2024",
                                    style: TextStyle(
                                      fontSize: 7.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Noto Kufi Arabic",
                                      color: Color(0xffAAAAAB),
                                    )
                                  ),
                                  SizedBox(width: 125.w),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => NewsDetails(news: news),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "معرفة المزيد",
                                        style: TextStyle(
                                          fontSize: 7.sp,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Noto Kufi Arabic",
                                          color: Color(0xff14B8A6),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}