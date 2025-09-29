import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_college/Models/Response/news_model.dart';
import 'package:smart_college/utils/colors.dart';
import 'package:smart_college/services/news_manager.dart';
import 'package:smart_college/View/Student/news_details.dart';

class AllNews extends StatefulWidget {
  AllNews({super.key});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  NewsModel? currentNews;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  // تحميل آخر خبر من API
  Future<void> _loadNews() async {
    try {
      final news = await NewsManager.getRandomNews();
      if (mounted) {
        setState(() {
          currentNews = news;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading news: $e');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

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
                    "آخر الأخبار",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Noto Kufi Arabic",
                      color: MyColors.blackColor,
                    ),
                  ),
                  
                  // كونتينر فارغ للمحاذاة
                  Container(
                    width: 39.w,
                    height: 38.h,
                  ),
                ],
              ),
            ),
          ),
          
          // عرض آخر خبر
          Positioned(
            top: 120.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : currentNews != null
                    ? SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            color: MyColors.whiteColor,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // صورة الخبر
                                if (currentNews!.mainImage.isNotEmpty)
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                                    child: Image.network(
                                      currentNews!.mainImage,
                                      width: double.infinity,
                                      height: 200.h,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          width: double.infinity,
                                          height: 200.h,
                                          color: Colors.grey[300],
                                          child: Icon(Icons.image_not_supported, size: 50),
                                        );
                                      },
                                    ),
                                  ),
                                
                                // محتوى الخبر
                                Padding(
                                  padding: EdgeInsets.all(15.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // عنوان الخبر
                                      Text(
                                        currentNews!.title,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Noto Kufi Arabic",
                                          color: MyColors.blackColor,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      
                                      SizedBox(height: 10.h),
                                      
                                      // محتوى الخبر
                                      Text(
                                        currentNews!.content,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Noto Kufi Arabic",
                                          color: MyColors.greyColor,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      
                                      SizedBox(height: 15.h),
                                      
                                      // تاريخ الخبر وزر المزيد
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            currentNews!.createdAt != null
                                                ? "${currentNews!.createdAt!.day} ${_months[currentNews!.createdAt!.month - 1]}, ${currentNews!.createdAt!.year}"
                                                : "17 أكتوبر, 2024",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Noto Kufi Arabic",
                                              color: Color(0xffAAAAAB),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => NewsDetails(news: currentNews!),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              "معرفة المزيد",
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Noto Kufi Arabic",
                                                color: MyColors.primaryColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: Text(
                          "لا توجد أخبار متاحة",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey,
                            fontFamily: "Noto Kufi Arabic",
                          ),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}