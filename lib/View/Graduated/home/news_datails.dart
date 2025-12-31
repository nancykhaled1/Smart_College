import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_college/Models/Response/news_model.dart';
import 'package:smart_college/utils/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NewsDetails extends StatefulWidget {
  final List<NewsModel> newsList;
  final int initialIndex;

  const NewsDetails({
    super.key,
    required this.newsList,
    this.initialIndex = 0,
  });

  // Constructor for backward compatibility (single news item)
  NewsDetails.single({super.key, required NewsModel news})
      : newsList = [news],
        initialIndex = 0;

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  late PageController _newsPageController;
  late PageController _imagePageController;
  int _currentNewsIndex = 0;
  
  @override
  void initState() {
    super.initState();
    _currentNewsIndex = widget.initialIndex;
    _newsPageController = PageController(initialPage: widget.initialIndex);
    _imagePageController = PageController();
  }

  @override
  void dispose() {
    _newsPageController.dispose();
    _imagePageController.dispose();
    super.dispose();
  }

  // Helper method to safely get total images count
  int _getTotalImagesCount(NewsModel news) {
    int count = 0;
    if (news.mainImage.isNotEmpty) count++;
    if (news.images.isNotEmpty) count += news.images.length;
    return count > 0 ? count : 1;
  }

  // Helper method to get image URL at index
  String? _getImageUrl(NewsModel news, int index) {
    if (news.mainImage.isNotEmpty) {
      if (index == 0) return news.mainImage;
      if (news.images.isNotEmpty && index - 1 < news.images.length) {
        return news.images[index - 1];
      }
    } else if (news.images.isNotEmpty && index < news.images.length) {
      return news.images[index];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Padding(
              padding: EdgeInsets.only(top: 10.h, left: 25.w, right: 25.w, bottom: 10.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 39.w,
                      height: 38.h,
                      decoration: BoxDecoration(
                        color: MyColors.whiteColor,
                        borderRadius: BorderRadius.circular(9),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
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
                  Spacer(),
                  // News counter
                  if (widget.newsList.length > 1)
                    Text(
                      "${_currentNewsIndex + 1} / ${widget.newsList.length}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Noto Kufi Arabic",
                        color: MyColors.blackColor,
                      ),
                    ),
                ],
              ),
            ),
            
            // News PageView
            Expanded(
              child: PageView.builder(
                controller: _newsPageController,
                itemCount: widget.newsList.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentNewsIndex = index;
                    _imagePageController = PageController(); // Reset image controller
                  });
                },
                itemBuilder: (context, index) {
                  final news = widget.newsList[index];
                  final totalImages = _getTotalImagesCount(news);
                  final hasMultipleImages = totalImages > 1;
                  
                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // News Images
                        Container(
                          height: 250.h,
                          margin: EdgeInsets.only(bottom: 20.h),
                          child: PageView.builder(
                            controller: _imagePageController,
                            itemCount: totalImages,
                            itemBuilder: (context, imgIndex) {
                              final imageUrl = _getImageUrl(news, imgIndex);
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
                                  child: imageUrl != null && imageUrl.isNotEmpty
                                      ? Image.network(
                                          imageUrl,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          loadingBuilder: (context, child, loadingProgress) {
                                            if (loadingProgress == null) return child;
                                            return Container(
                                              color: Colors.grey[200],
                                              child: Center(
                                                child: CircularProgressIndicator(
                                                  value: loadingProgress.expectedTotalBytes != null
                                                      ? loadingProgress.cumulativeBytesLoaded /
                                                          loadingProgress.expectedTotalBytes!
                                                      : null,
                                                  color: MyColors.primaryColor,
                                                ),
                                              ),
                                            );
                                          },
                                          errorBuilder: (context, error, stackTrace) =>
                                              _buildPlaceholderImage(),
                                        )
                                      : _buildPlaceholderImage(),
                                ),
                              );
                            },
                          ),
                        ),
                        
                        // Image Indicator
                        if (hasMultipleImages)
                          Padding(
                            padding: EdgeInsets.only(bottom: 25.h),
                            child: Center(
                              child: SmoothPageIndicator(
                                controller: _imagePageController,
                                count: totalImages,
                                effect: ExpandingDotsEffect(
                                  dotHeight: 8,
                                  dotWidth: 8,
                                  activeDotColor: MyColors.primaryColor,
                                  dotColor: Colors.grey.withOpacity(0.3),
                                  spacing: 8,
                                ),
                              ),
                            ),
                          ),
                        
                        // News Content
                        Container(
                          width: double.infinity,
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
                              // Title
                              Text(
                                news.title.isNotEmpty ? news.title : "بدون عنوان",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Noto Kufi Arabic",
                                  color: MyColors.blackColor,
                                  height: 1.4,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              
                              SizedBox(height: 15.h),
                              
                              // Date
                              if (news.createdAt != null)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 14.sp,
                                      color: Color(0xffAAAAAB),
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      _formatDate(news.createdAt!),
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Noto Kufi Arabic",
                                        color: Color(0xffAAAAAB),
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ],
                                )
                              else
                                Text(
                                  "تاريخ غير متاح",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Noto Kufi Arabic",
                                    color: Colors.grey,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              
                              SizedBox(height: 20.h),
                              
                              Divider(color: Colors.grey.withOpacity(0.3), thickness: 1),
                              
                              SizedBox(height: 20.h),
                              
                              // Content
                              Text(
                                news.content.isNotEmpty ? news.content : "لا يوجد محتوى متاح",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Noto Kufi Arabic",
                                  color: news.content.isNotEmpty 
                                      ? MyColors.blackColor 
                                      : Colors.grey,
                                  height: 1.8,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: 30.h),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for placeholder image
  Widget _buildPlaceholderImage() {
    return Container(
      color: Colors.grey[300],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_not_supported,
              size: 50.sp,
              color: Colors.grey[600],
            ),
            SizedBox(height: 8.h),
            Text(
              "صورة غير متاحة",
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: "Noto Kufi Arabic",
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to format date
  String _formatDate(DateTime date) {
    final months = [
      'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
      'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'
    ];
    return '${date.day} ${months[date.month - 1]}, ${date.year}';
  }
}