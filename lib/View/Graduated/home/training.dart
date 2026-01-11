import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_college/Cubits/Templates/TemplateCubit.dart';
import 'package:smart_college/Cubits/Templates/TemplateStates.dart';
import 'package:smart_college/Models/Response/templateModel.dart';
import 'package:smart_college/View/widgets/common_bottom_navigation.dart';
import 'package:smart_college/View/widgets/common_top_search_bar.dart';
import 'package:smart_college/utils/colors.dart';

class TrainingPage extends StatefulWidget {
  const TrainingPage({super.key});
  static const String routeName = 'trainingPage';

  @override
  State<TrainingPage> createState() => __TrainingPage();
}

class __TrainingPage extends State<TrainingPage> {
  TextEditingController _searchController = TextEditingController();
  int _currentIndex = 3;
  Timer? _debounceTimer;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    context.read<TemplateCubit>().getTemplates();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      final query = _searchController.text.trim();
      if (query.isEmpty) {
        setState(() {
          _isSearching = false;
        });
        context.read<TemplateCubit>().getTemplates();
      } else {
        setState(() {
          _isSearching = true;
        });
        context.read<TemplateCubit>().searchTemplates(query);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: Column(
        children: [
          CommonTopSearchBar(controller: _searchController),
          Expanded(
            child: BlocBuilder<TemplateCubit, TemplateStates>(
              builder: (context, state) {
                if (_isSearching) {
                  if (state is TemplateSearchLoadingState) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(color: MyColors.primaryColor),
                          SizedBox(height: 20.h),
                          Text(
                            state.loadingMessage ?? "جاري البحث عن القوالب...",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "Noto Kufi Arabic",
                              color: MyColors.greyColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is TemplateSearchErrorState) {
                    return _buildErrorWidget(
                      state.errorMessage ?? "حدث خطأ غير معروف",
                      () => context.read<TemplateCubit>().searchTemplates(_searchController.text.trim()),
                    );
                  } else if (state is TemplateSearchSuccessState) {
                    final trainingTemplates = state.response.data
                        .where((template) => template.category.toLowerCase() == 'training')
                        .toList();

                    if (trainingTemplates.isEmpty) {
                      return Center(
                        child: Text(
                          "لا توجد نتائج للبحث",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey,
                            fontFamily: "Noto Kufi Arabic",
                          ),
                        ),
                      );
                    }
                    return _buildTemplatesList(trainingTemplates);
                  }
                  return SizedBox.shrink();
                }

                if (state is TemplateLoadingState) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: MyColors.primaryColor),
                        SizedBox(height: 20.h),
                        Text(
                          state.loadingMessage ?? "جاري تحميل القوالب...",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: "Noto Kufi Arabic",
                            color: MyColors.greyColor,
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is TemplateErrorState) {
                  return _buildErrorWidget(
                    state.errorMessage ?? "حدث خطأ غير معروف",
                    () => context.read<TemplateCubit>().getTemplates(),
                  );
                } else if (state is TemplateSuccessState) {
                  final trainingTemplates = state.response.data
                      .where((template) => template.category.toLowerCase() == 'training')
                      .toList();

                  if (trainingTemplates.isEmpty) {
                    return Center(
                      child: Text(
                        "لا توجد قوالب تدريبية متاحة",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey,
                          fontFamily: "Noto Kufi Arabic",
                        ),
                      ),
                    );
                  }
                  return _buildTemplatesList(trainingTemplates);
                }
                return SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String message, VoidCallback onRetry) {
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
              message,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: "Noto Kufi Arabic",
                color: Colors.red[700],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            ElevatedButton.icon(
              onPressed: onRetry,
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
  }

  Widget _buildTemplatesList(List<Template> trainingTemplates) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      itemCount: trainingTemplates.length,
      itemBuilder: (context, index) {
        final template = trainingTemplates[index];
        
        // Get the first available image
        String? imageUrl;
        if (template.image != null && template.image!.isNotEmpty) {
          imageUrl = template.image;
        } else if (template.images != null && template.images!.isNotEmpty) {
          imageUrl = template.images!.first;
        }

        return Container(
          margin: EdgeInsets.only(bottom: 16.h),
          decoration: BoxDecoration(
            color: MyColors.whiteColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Single Image Section
                if (imageUrl != null && imageUrl.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      imageUrl,
                      width: double.infinity,
                      height: 200.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          height: 200.h,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_not_supported,
                                size: 50,
                                color: Colors.grey[400],
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'فشل تحميل الصورة',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey[500],
                                  fontFamily: "Noto Kufi Arabic",
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          width: double.infinity,
                          height: 200.h,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: MyColors.primaryColor,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                if (imageUrl != null && imageUrl.isNotEmpty)
                  SizedBox(height: 16.h),
                
                // Title
                Text(
                  template.title,
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
                
                // Content
                Text(
                  template.content,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: "Noto Kufi Arabic",
                    color: MyColors.textColor,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 15.h),
                
                // Location
                if (template.location != null && template.location!.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Row(
                      children: [
                       SvgPicture.asset(
                          'assets/images/location.svg',
                          width: 18.w,
                          height: 18.h,
                          color: MyColors.primaryColor,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            template.location!,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: "Noto Kufi Arabic",
                              color: MyColors.greyColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                
                // Start Date and End Date
                if (template.startDate != null && template.endDate != null)
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/calendar.svg',
                          width: 18.w,
                          height: 18.h,
                          color: MyColors.primaryColor,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            "${_formatDate(template.startDate!)} – ${_formatDate(template.endDate!)}",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: "Noto Kufi Arabic",
                              color: MyColors.greyColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                
                // Company Name
                if (template.companyName != null && template.companyName!.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/building.svg',
                          width: 18.w,
                          height: 18.h,
                    
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            template.companyName!,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: "Noto Kufi Arabic",
                              color: MyColors.greyColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                
                SizedBox(height: 10.h),
                
                // Apply Button
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "تم التقديم بنجاح على: ${template.title}",
                            style: TextStyle(fontFamily: "Noto Kufi Arabic"),
                          ),
                          backgroundColor: MyColors.primaryColor,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 12.h),
                      elevation: 2,
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
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}