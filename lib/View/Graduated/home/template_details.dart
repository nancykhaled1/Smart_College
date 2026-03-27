import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_college/Models/Response/templateModel.dart';
import 'package:smart_college/utils/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TemplateDetails extends StatefulWidget {
  final List<Template> templateList;
  final int initialIndex;
  
  const TemplateDetails({
    super.key, 
    required this.templateList,
    this.initialIndex = 0,
  });

  // Constructor for backward compatibility (single template item)
  TemplateDetails.single({super.key, required Template template})
      : templateList = [template],
        initialIndex = 0;
  
  @override
  State<TemplateDetails> createState() => _TemplateDetailsState();
}

class _TemplateDetailsState extends State<TemplateDetails> {
  late PageController _templatePageController;
  late PageController _imagePageController;
  int _currentTemplateIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentTemplateIndex = widget.initialIndex;
    _templatePageController = PageController(initialPage: widget.initialIndex);
    _imagePageController = PageController();
  }

  @override
  void dispose() {
    _templatePageController.dispose();
    _imagePageController.dispose();
    super.dispose();
  }

  int _getTotalImagesCount(Template template) {
    int count = 0;
    if (template.image != null && template.image!.isNotEmpty) count++;
    if (template.images != null && template.images!.isNotEmpty) {
      count += template.images!.length;
    }
    return count > 0 ? count : 1;
  }

  String? _getImageUrl(Template template, int index) {
    if (template.image != null && template.image!.isNotEmpty) {
      if (index == 0) return template.image;
      if (template.images != null && template.images!.isNotEmpty && index - 1 < template.images!.length) {
        return template.images![index - 1];
      }
    } else if (template.images != null && template.images!.isNotEmpty && index < template.images!.length) {
      return template.images![index];
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
                  // Template counter
                  if (widget.templateList.length > 1)
                    Text(
                      "${_currentTemplateIndex + 1} / ${widget.templateList.length}",
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
            
            // Template PageView
            Expanded(
              child: PageView.builder(
                controller: _templatePageController,
                itemCount: widget.templateList.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentTemplateIndex = index;
                    _imagePageController = PageController(); // Reset image controller
                  });
                },
                itemBuilder: (context, index) {
                  final template = widget.templateList[index];
                  final totalImages = _getTotalImagesCount(template);
                  final hasMultipleImages = totalImages > 1;
                  
                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Template Images
                        Container(
                          height: 250.h,
                          margin: EdgeInsets.only(bottom: 20.h),
                          child: PageView.builder(
                            controller: _imagePageController,
                            itemCount: totalImages,
                            itemBuilder: (context, imgIndex) {
                              final imageUrl = _getImageUrl(template, imgIndex);
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: imageUrl != null
                                    ? Image.network(
                                        imageUrl,
                                        width: double.infinity,
                                        height: 250.h,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            width: double.infinity,
                                            height: 250.h,
                                            color: Colors.grey[300],
                                            child: Icon(Icons.image_not_supported, size: 50),
                                          );
                                        },
                                      )
                                    : Container(
                                        width: double.infinity,
                                        height: 250.h,
                                        color: Colors.grey[300],
                                        child: Icon(Icons.image_not_supported, size: 50),
                                      ),
                              );
                            },
                          ),
                        ),
                        
                        // Image Indicator
                        if (hasMultipleImages)
                          Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: Center(
                              child: SmoothPageIndicator(
                                controller: _imagePageController,
                                count: totalImages,
                                effect: WormEffect(
                                  dotColor: Colors.grey[300]!,
                                  activeDotColor: MyColors.primaryColor,
                                  dotHeight: 8,
                                  dotWidth: 8,
                                ),
                              ),
                            ),
                          ),
                        
                        // Template Title
                        Text(
                          template.title.isNotEmpty ? template.title : "لا يوجد عنوان",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Noto Kufi Arabic",
                            color: MyColors.blackColor,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        
                        // Category Badge
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: MyColors.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            template.category.isNotEmpty ? template.category : "غير محدد",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: "Noto Kufi Arabic",
                              color: MyColors.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        
                        // Date
                        Row(
                          children: [
                            Icon(Icons.calendar_today, size: 18, color: MyColors.greyColor),
                            SizedBox(width: 8.w),
                            Text(
                              template.formattedCreatedDate,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: "Noto Kufi Arabic",
                                color: MyColors.greyColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25.h),
                        
                        // Description
                        Text(
                          "الوصف",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Noto Kufi Arabic",
                            color: MyColors.blackColor,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          template.description.isNotEmpty ? template.description : "لا يوجد وصف متاح",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: "Noto Kufi Arabic",
                            color: MyColors.textColor,
                            height: 1.6,
                          ),
                        ),
                        SizedBox(height: 30.h),
                        
                        // Apply Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle apply action
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "تم التقديم بنجاح",
                                    style: TextStyle(fontFamily: "Noto Kufi Arabic"),
                                  ),
                                  backgroundColor: MyColors.primaryColor,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.primaryColor,
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              "قدم الآن",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Noto Kufi Arabic",
                                color: MyColors.whiteColor,
                              ),
                            ),
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
}

