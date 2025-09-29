import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_college/Models/Response/news_model.dart';
import 'package:smart_college/utils/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NewsDetails extends StatelessWidget {
  final NewsModel news;
  
  const NewsDetails({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final controller = PageController();
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: Column(
        children: [
         
          Padding(
            padding: EdgeInsets.only(top: 50.h, left: 25.w, right: 25.w),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
           
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
               
                
               
              ],
            ),
          ),
         
                SizedBox(height: 25.h),
        
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              
                  Container(
                    height: 250.h,
                    child: PageView.builder(
                      controller: controller,
                      itemCount: 1 + (news.images.length),
                      itemBuilder: (context, index) {
                        final String imageUrl = index == 0
                            ? news.mainImage
                            : news.images[index - 1];
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    color: Colors.grey[300],
                                    child: Icon(Icons.image_not_supported),
                                  ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  
                  SizedBox(height: 20.h),
            
                    Center(
                      child: SmoothPageIndicator(
                        controller: controller, 
                        count: 1 + (news.images.length),
                        effect: ExpandingDotsEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          activeDotColor: MyColors.primaryColor,
                          dotColor: Colors.grey.withOpacity(0.3),
                        ),
                      ),
                    ),
                  
                  SizedBox(height: 25.h),
                  
               
                  SingleChildScrollView(
                    child: Container(
                      height: 360.h,
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // عنوان الخبر
                          Text(
                            news.title,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Noto Kufi Arabic",
                              color: MyColors.softBlackColor,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          
                          SizedBox(height: 10.h),
                          
                          // التاريخ
                          if (news.createdAt != null)
                            Text(
                              _formatDate(news.createdAt!),
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Noto Kufi Arabic",
                                color: Color(0xffAAAAAB),
                              ),
                              textAlign: TextAlign.right,
                            ),
                          
                          SizedBox(height: 15.h),
                          
                          // وصف الخبر
                          if (news.content.isNotEmpty)
                            Text(
                              news.content,
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Noto Kufi Arabic",
                                color: MyColors.blackColor,
                                height: 1.6,
                              ),
                              textAlign: TextAlign.right,
                            ),
                        ],
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 15.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
 
  
  String _formatDate(DateTime date) {
    final months = [
      'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
      'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'
    ];
    return '${date.day} ${months[date.month - 1]}, ${date.year}';
  }
}