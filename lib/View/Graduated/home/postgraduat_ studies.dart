import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_college/Cubits/Templates/TemplateCubit.dart';
import 'package:smart_college/Cubits/Templates/TemplateStates.dart';
import 'package:smart_college/Models/Response/templateModel.dart';
import 'package:smart_college/View/Graduated/home/template_details.dart';
import 'package:smart_college/View/widgets/common_bottom_navigation.dart';
import 'package:smart_college/View/widgets/common_top_search_bar.dart';
import 'package:smart_college/utils/colors.dart';

class PostgraduatStudies extends StatefulWidget {
  const PostgraduatStudies({super.key});
  static const String routeName = 'postgraduatStudies';

  @override
  State<PostgraduatStudies> createState() => _PostgraduatStudiesState();
}

class _PostgraduatStudiesState extends State<PostgraduatStudies> {
  int selectedIndex = 0; // للتحكم في الزر المختار (0=Masters, 1=Doctorate, 2=Diploma)
  int  _currentIndex = 1; // Postgraduate Studies
  TextEditingController _searchController = TextEditingController();
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

  String _getCategoryForIndex(int index) {
    switch (index) {
      case 0:
        return 'Masters';
      case 1:
        return 'Doctorate';
      case 2:
        return 'Diploma';
      default:
        return 'Masters';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(   

      backgroundColor: Color(0xffF5F5F5),
      
      body: SingleChildScrollView(
        
        

        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
      CommonTopSearchBar(controller: _searchController),

              SizedBox(height: 30.h),
              
              // ✅ الأزرار الثلاثة
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTabButton(
                    index: 0,
                    iconPath: 'assets/images/student1.svg',
                    label: 'ماجستير',
                  ),
                  _buildTabButton(
                    index: 1,
                    iconPath: 'assets/images/book.svg', // غير الأيقونة حسب الحاجة
                    label: 'دكتوراه',
                  ),
                  _buildTabButton(
                    index: 2,
                    iconPath: 'assets/images/diploma.svg', // غير الأيقونة حسب الحاجة
                    label: 'Diplomas',
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              // المحتوى حسب الزر المختار
              _buildContent(),
            ],
          ),
        ),
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

  // ✅ Widget للزر
  Widget _buildTabButton({
    required int index,
    required String iconPath,
    required String label,
  }) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        width: 100.w,
        height: 100.h,
        decoration: BoxDecoration(
          color: MyColors.whiteColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? MyColors.primaryColor : Colors.grey.shade300,
            width: isSelected ? 1 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: MyColors.primaryColor.withOpacity(0.2),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 40.w,
              height: 40.h,
             // color: isSelected ? MyColors.primaryColor : MyColors.greyColor,
            ),
            SizedBox(height: 8.h),
            Text(
              label,
              style: TextStyle(
                fontFamily: "Noto Kufi Arabic",
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
                color: MyColors.blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ المحتوى حسب الزر المختار
  Widget _buildContent() {
    return BlocBuilder<TemplateCubit, TemplateStates>(
      builder: (context, state) {
        // Handle search states
        if (_isSearching) {
          if (state is TemplateSearchLoadingState) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(20.w),
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
              ),
            );
          } else if (state is TemplateSearchErrorState) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(20.w),
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
            // Filter templates by selected category
            final category = _getCategoryForIndex(selectedIndex);
            final filteredTemplates = state.response.data
                .where((template) => template.category.toLowerCase() == category.toLowerCase())
                .toList();

            if (filteredTemplates.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Text(
                    "لا توجد نتائج للبحث",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey,
                      fontFamily: "Noto Kufi Arabic",
                    ),
                  ),
                ),
              );
            }

            return _buildTemplatesListView(filteredTemplates);
          }
          return SizedBox.shrink();
        }

        // Handle regular states
        if (state is TemplateLoadingState) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(20.w),
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
            ),
          );
        } else if (state is TemplateErrorState) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(20.w),
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
          // Filter templates by selected category
          final category = _getCategoryForIndex(selectedIndex);
          final filteredTemplates = state.response.data
              .where((template) => template.category.toLowerCase() == category.toLowerCase())
              .toList();

          if (filteredTemplates.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Text(
                  "لا توجد قوالب متاحة لهذا التصنيف",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey,
                    fontFamily: "Noto Kufi Arabic",
                  ),
                ),
              ),
            );
          }

          return _buildTemplatesListView(filteredTemplates);
        }
        return SizedBox.shrink();
      },
    );
  }

  Widget _buildTemplatesListView(List<Template> filteredTemplates) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: filteredTemplates.length,
      itemBuilder: (context, index) {
        final template = filteredTemplates[index];
        return _buildTemplateCard(
          context: context,
          template: template,
          templateList: filteredTemplates,
          index: index,
        );
      },
    );
  }

  Widget _buildTemplateCard({
    required BuildContext context,
    required Template template,
    required List<Template> templateList,
    required int index,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: MyColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TemplateDetails(
                templateList: templateList,
                initialIndex: index,
              ),
            ),
          );
        },
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
                height: 180.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 180.h,
                    color: Colors.grey[300],
                    child: Icon(Icons.image_not_supported, size: 40),
                  );
                },
              ),
            ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  template.title,
                  style: TextStyle(
                    fontFamily: "Noto Kufi Arabic",
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: MyColors.blackColor,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  template.description,
                  style: TextStyle(
                    fontFamily: "Noto Kufi Arabic",
                    fontWeight: FontWeight.w500,
                    fontSize: 10.sp,
                    color: MyColors.textColor,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 15.h),
                Row(
                  children: [
                    SvgPicture.asset('assets/images/calendar.svg'),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        template.formattedCreatedDate,
                        style: TextStyle(
                          fontFamily: "Noto Kufi Arabic",
                          fontWeight: FontWeight.w500,
                          fontSize: 10.sp,
                          color: MyColors.greyColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TemplateDetails(
                              templateList: templateList,
                              initialIndex: index,
                            ),
                          ),
                        );
                      },
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
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
  
}


