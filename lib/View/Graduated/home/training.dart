import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_college/Cubits/Templates/TemplateCubit.dart';
import 'package:smart_college/Cubits/Templates/TemplateStates.dart';
import 'package:smart_college/Models/Response/templateModel.dart';
import 'package:smart_college/View/Graduated/home/template_details.dart';
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
  int _currentIndex = 3; // Training
  Timer? _debounceTimer;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    // Fetch templates when screen loads
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
                // Handle search states
                if (_isSearching) {
                  if (state is TemplateSearchLoadingState) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: MyColors.primaryColor,
                          ),
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
                    return Center(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline, color: Colors.red, size: 50),
                            SizedBox(height: 15.h),
                            Text(
                              "حدث خطأ في البحث",
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
                                context.read<TemplateCubit>().searchTemplates(_searchController.text.trim());
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
                  } else if (state is TemplateSearchSuccessState) {
                    // Filter templates by category = "Training"
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

                // Handle regular states
                if (state is TemplateLoadingState) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: MyColors.primaryColor,
                        ),
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
                              context.read<TemplateCubit>().getTemplates();
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
                } else if (state is TemplateSuccessState) {
                  // Filter templates by category = "Training"
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
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index != _currentIndex) {
            String route;
            switch (index) {
              case 0:
                route = 'gradhome';
                break;
              case 1:
                route = 'postgraduatStudies';
                break;
              case 2:
                route = 'gradhome'; // Chat
                break;
              case 3:
                route = 'trainingPage';
                break;
              case 4:
              default:
                route = 'dashboardPage';
                break;
            }
            Navigator.pushNamed(context, route);
          }
        },
      ),
    );
  }

  Widget _buildTemplatesList(List<Template> trainingTemplates) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      itemCount: trainingTemplates.length,
      itemBuilder: (context, index) {
        final template = trainingTemplates[index];
        return Card(
          margin: EdgeInsets.only(bottom: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TemplateDetails(
                    templateList: trainingTemplates,
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
                  // Template Image
                  if (template.image != null && template.image!.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(
                        template.image!,
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
                  
                  // Template Content
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        // Description
                        Text(
                          template.description,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: "Noto Kufi Arabic",
                            color: MyColors.textColor,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 15.h),
                        // Date
                        Row(
                          children: [
                            Icon(Icons.calendar_today, size: 16, color: MyColors.greyColor),
                            SizedBox(width: 8.w),
                            Text(
                              template.formattedCreatedDate,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: "Noto Kufi Arabic",
                                color: MyColors.greyColor,
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
}
