import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:smart_college/utils/colors.dart';
import 'package:smart_college/Cubits/News/NewsCubit.dart';
import 'package:smart_college/Cubits/News/NewsStates.dart';
import 'package:smart_college/View/Student/news_details.dart';
import 'package:smart_college/View/Auth/Login/login.dart';

class AllNews extends StatefulWidget {
  AllNews({super.key});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
   @override
   void initState() {
     super.initState();
     // Fetch news when screen loads
     context.read<NewsCubit>().getNews();
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
            top: 120.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: BlocBuilder<NewsCubit, NewsStates>(
              builder: (context, state) {
                // Debug: Print current state
                print("News State: ${state.runtimeType}");
                
                if (state is NewsLoadingState) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: MyColors.primaryColor,
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          state.loadingMessage ?? "جاري تحميل الأخبار...",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: "Noto Kufi Arabic",
                            color: MyColors.greyColor,
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is NewsErrorState) {
                  // Debug: Print error details
                  print("News Error: ${state.errorMessage}");
                  
                  return Center(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline, color: Colors.red, size: 50),
                          SizedBox(height: 15.h),
                          Text(
                            "حدث خطأ",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontFamily: "Noto Kufi Arabic",
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            state.errorMessage ?? "حدث خطأ غير معروف",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "Noto Kufi Arabic",
                              color: Colors.red[700],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20.h),
                          ElevatedButton.icon(
                            onPressed: () {
                              print("Retrying news fetch...");
                              context.read<NewsCubit>().getNews();
                            },
                            icon: Icon(Icons.refresh),
                            label: Text(
                              "إعادة المحاولة",
                              style: TextStyle(fontFamily: "Noto Kufi Arabic"),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.primaryColor,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (state is NewsSuccessState) {
                  final newsList = state.response.data;
                  if (newsList.isEmpty) {
                    return Center(
                      child: Text(
                        "لا توجد أخبار متاحة",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey,
                          fontFamily: "Noto Kufi Arabic",
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
                    itemCount: newsList.length,
                    itemBuilder: (context, index) {
                      final news = newsList[index];
                      return Card(
                        margin: EdgeInsets.only(bottom: 15.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsDetails(
                                  newsList: newsList,
                                  initialIndex: index,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            color: MyColors.whiteColor,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // صورة الخبر
                                if (news.mainImage.isNotEmpty)
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                                    child: Image.network(
                                      news.mainImage,
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
                                        news.title,
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
                                        news.content.length > 100 
                                            ? news.content.substring(0, 100) + "..."
                                            : news.content,
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
                                      
                                     
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${news.createdAt.day} ${_months[news.createdAt.month - 1]}, ${news.createdAt.year}",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Noto Kufi Arabic",
                                              color: Color(0xffAAAAAB),
                                            ),
                                          ),
                                          Text(
                                            "معرفة المزيد",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Noto Kufi Arabic",
                                              color: MyColors.primaryColor,
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
                      );
                    },
                  );
                }
                // Initial state - show loading or fetch news
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: MyColors.primaryColor,
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "جاري تحميل الأخبار...",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "Noto Kufi Arabic",
                          color: MyColors.greyColor,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}