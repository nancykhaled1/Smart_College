import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_college/Models/Response/newsModel.dart';
import 'package:smart_college/utils/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NewsDetails extends StatefulWidget {
  final News news;
  
  const NewsDetails({
    super.key, 
    required this.news,
  });
  
  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  late PageController _imagePageController;

  @override
  void initState() {
    super.initState();
    _imagePageController = PageController();
  }

  @override
  void dispose() {
    _imagePageController.dispose();
    super.dispose();
  }

  int _getTotalImagesCount() {
    int count = 0;
    if (widget.news.mainImage.isNotEmpty) count++;
    if (widget.news.images.isNotEmpty) count += widget.news.images.length;
    return count > 0 ? count : 1;
  }

  String? _getImageUrl(int index) {
    if (widget.news.mainImage.isNotEmpty) {
      if (index == 0) return widget.news.mainImage;
      if (widget.news.images.isNotEmpty && index - 1 < widget.news.images.length) {
        return widget.news.images[index - 1];
      }
    } else if (widget.news.images.isNotEmpty && index < widget.news.images.length) {
      return widget.news.images[index];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final totalImages = _getTotalImagesCount();
    final hasMultipleImages = totalImages > 1;

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // App Bar with back button only
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
                            offset: const Offset(0, 2),
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
                ],
              ),
            ),
            
            // News Content
            Expanded(
              child: SingleChildScrollView(
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
                          final imageUrl = _getImageUrl(imgIndex);
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 8.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
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
                    
                    // Image Indicator (only show if multiple images)
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
                    
                    // News Content Card
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
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Text(
                            widget.news.title.isNotEmpty ? widget.news.title : "بدون عنوان",
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 14.sp,
                                color: const Color(0xffAAAAAB),
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                _formatDate(widget.news.createdAt),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Noto Kufi Arabic",
                                  color: const Color(0xffAAAAAB),
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                          
                          SizedBox(height: 20.h),
                          
                          Divider(color: Colors.grey.withOpacity(0.3), thickness: 1),
                          
                          SizedBox(height: 20.h),
                          
                          // Content
                          Text(
                            widget.news.content.isNotEmpty ? widget.news.content : "لا يوجد محتوى متاح",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Noto Kufi Arabic",
                              color: widget.news.content.isNotEmpty 
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      color: Colors.grey[300],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image_not_supported, size: 50.sp, color: Colors.grey[600]),
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
  
  String _formatDate(DateTime date) {
    const months = [
      'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
      'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'
    ];
    return '${date.day} ${months[date.month - 1]}, ${date.year}';
  }
}
