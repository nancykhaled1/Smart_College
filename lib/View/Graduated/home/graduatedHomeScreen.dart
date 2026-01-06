import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:smart_college/View/Graduated/home/training.dart';
import 'package:smart_college/View/widgets/common_top_search_bar.dart';
import 'package:smart_college/View/widgets/common_bottom_navigation.dart';
import 'package:smart_college/utils/colors.dart';
import 'package:smart_college/Cubits/News/NewsCubit.dart';
import 'package:smart_college/Cubits/News/NewsStates.dart';
import 'package:smart_college/Cubits/Templates/TemplateCubit.dart';
import 'package:smart_college/Cubits/Templates/TemplateStates.dart';
import 'package:smart_college/Models/Response/newsModel.dart';
import 'package:smart_college/Models/Response/news_model.dart';
import 'package:smart_college/Models/Response/templateModel.dart';
import 'package:smart_college/View/Graduated/home/all_news.dart';
import 'package:smart_college/View/Graduated/home/news_datails.dart';
import 'package:smart_college/View/Graduated/home/template_details.dart';
import 'package:smart_college/View/Graduated/home/dashboard.dart';
import 'package:smart_college/View/Graduated/home/postgraduat_ studies.dart';
import '../../Student/Profile/ProfileScreen.dart';

class GraduatedHomeScreen extends StatefulWidget {
  static const String routeName = 'gradhome';

  const GraduatedHomeScreen({super.key});

  @override
  State<GraduatedHomeScreen> createState() => GraduatedHomeScreenState();
}

class GraduatedHomeScreenState extends State<GraduatedHomeScreen> {
  int _currentIndex = 0;
  late TextEditingController _searchController;

  final List<String> _months = [
    'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
    'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر',
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    context.read<NewsCubit>().getNews();
    context.read<TemplateCubit>().getTemplates();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  NewsModel _convertNewsToNewsModel(News news) {
    return NewsModel(
      title: news.title,
      content: news.content,
      mainImage: news.mainImage,
      images: news.images,
      createdAt: news.createdAt,
    );
  }

  void _handleNavigation(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _getCurrentScreen() {
    switch (_currentIndex) {
      case 0:
        return _buildHomeContent();
      case 1:
        return PostgraduatStudies();
      case 2:
        return Center(
          child: Text(
            'Chat Screen',
            style: TextStyle(
              fontSize: 20.sp,
              fontFamily: "Noto Kufi Arabic",
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      case 3:
        return TrainingPage();
      case 4:
        return DashboardPage();
      default:
        return _buildHomeContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: _getCurrentScreen(),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: _handleNavigation,
      ),
    );
  }

  Widget _buildHomeContent() {
    return Column(
      children: [
        CommonTopSearchBar(controller: _searchController),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGraduatesStatisticsCard(),
                SizedBox(height: 20.h),
                _buildTrainingCard(),
                SizedBox(height: 10.h),
                Divider(
                  color: MyColors.greyColor.withOpacity(0.5),
                  thickness: 0.5,
                ),
                SizedBox(height: 24.h),
                _buildNewsHeader(),
                _buildNewsList(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGraduatesStatisticsCard() {
    return Container(
      height: 200.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: MyColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildCardHeader(),
          SizedBox(height: 20.h),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCircle("30%", "باحث عن عمل", 0.30, 
                    [MyColors.pnkcolor, const Color(0xff14B8A6)]),
                _buildCircle("66%", "موظف", 0.66, 
                    [const Color(0xffDA9240), MyColors.pnkcolor2]),
                _buildCircle("85%", "عامل حر", 0.85, 
                    [const Color(0xff7563E7), MyColors.pnkcolor2]),
                _buildCircle("90%", "دراسات عليا", 0.90, 
                    [const Color(0xffFBAA95), MyColors.pnkcolor2]),
              ],
            ),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  Widget _buildCardHeader() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(8.w),
          child: SvgPicture.asset('assets/images/graduation-cap.svg'),
        ),
        SizedBox(width: 5.w),
        Text(
          "الخريجين",
          style: TextStyle(
            fontSize: 15.sp,
            color: MyColors.blackColor,
            fontWeight: FontWeight.w500,
            fontFamily: 'Noto Kufi Arabic',
          ),
        ),
        const Spacer(),
        SvgPicture.asset('assets/images/Rectangle.svg'),
      ],
    );
  }

  Widget _buildTrainingCard() {
    return BlocBuilder<TemplateCubit, TemplateStates>(
      builder: (context, state) {
        Template? lastTraining;
        
        if (state is TemplateSuccessState) {
          final trainingTemplates = state.response.data
              .where((template) => template.category.toLowerCase() == 'training')
              .toList();
          
          if (trainingTemplates.isNotEmpty) {
            trainingTemplates.sort((a, b) => b.createdAt.compareTo(a.createdAt));
            lastTraining = trainingTemplates.first;
          }
        }
        
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: MyColors.whiteColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: lastTraining != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lastTraining.title,
                      style: TextStyle(
                        fontFamily: "Noto Kufi Arabic",
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        color: MyColors.blackColor,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      lastTraining.content,
                      style: TextStyle(
                        fontFamily: "Noto Kufi Arabic",
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                        color: MyColors.textColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildTrainingDetails(lastTraining)),
                        SizedBox(width: 12.w),
                        SvgPicture.asset('assets/images/Mobile.svg'),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 8.h),
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
                )
              : Container(
                  padding: EdgeInsets.all(20.w),
                  child: Center(
                    child: Text(
                      "لا توجد تدريبات متاحة",
                      style: TextStyle(
                        fontFamily: "Noto Kufi Arabic",
                        fontSize: 14.sp,
                        color: MyColors.greyColor,
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget _buildTrainingDetails(Template? template) {
    if (template == null) {
      return const SizedBox.shrink();
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset('assets/images/location.svg'),
            SizedBox(width: 5.w),
            Expanded(
              child: Text(
                template.location ?? "موقع غير محدد",
                style: TextStyle(
                  fontFamily: "Noto Kufi Arabic",
                  fontWeight: FontWeight.w500,
                  fontSize: 10.sp,
                  color: MyColors.greyColor,
                ),
              ),
            ),
            if (template.startDate != null && template.endDate != null) ...[
              SizedBox(width: 8.w),
              SvgPicture.asset('assets/images/calendar.svg'),
              SizedBox(width: 5.w),
              Expanded(
                child: Text(
                  "${_formatDate(template.startDate!)} – ${_formatDate(template.endDate!)}",
                  style: TextStyle(
                    fontFamily: "Noto Kufi Arabic",
                    fontWeight: FontWeight.w500,
                    fontSize: 10.sp,
                    color: MyColors.greyColor,
                  ),
                ),
              ),
            ],
          ],
        ),
        SizedBox(height: 10.h),
        _buildDetailRow(
          'assets/images/building.svg', 
          template.companyName ?? "اسم الشركة غير محدد"
        ),
        SizedBox(height: 10.h),
        _buildDetailRow('assets/images/map.svg', "View in Map"),
      ],
    );
  }
  
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Widget _buildDetailRow(String icon, String text) {
    return Row(
      children: [
        SvgPicture.asset(icon),
        SizedBox(width: 5.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: "Noto Kufi Arabic",
              fontWeight: FontWeight.w500,
              fontSize: 10.sp,
              color: MyColors.greyColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNewsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 15.w),
          child: Text(
            "احدث الفعاليات و الاخبار",
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              fontFamily: "Noto Kufi Arabic",
              color: MyColors.blackColor,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AllNews()),
            );
          },
          child: Text(
            "عرض كل الاخبار",
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              fontFamily: "Noto Kufi Arabic",
              color: MyColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNewsList() {
    return BlocBuilder<NewsCubit, NewsStates>(
      builder: (context, state) {
        if (state is NewsLoadingState) {
          return Center(
            child: CircularProgressIndicator(color: MyColors.primaryColor),
          );
        } else if (state is NewsErrorState) {
          return _buildErrorWidget(state.errorMessage ?? "حدث خطأ");
        } else if (state is NewsSuccessState) {
          final newsList = state.response.data;
          if (newsList.isEmpty) {
            return Center(
              child: Text(
                "لا توجد أخبار متاحة",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: "Noto Kufi Arabic",
                  color: MyColors.greyColor,
                ),
              ),
            );
          }
          return _buildNewsListView(newsList);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 40),
          SizedBox(height: 10.h),
          Text(
            message,
            style: TextStyle(
              fontSize: 12.sp,
              fontFamily: "Noto Kufi Arabic",
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.h),
          ElevatedButton(
            onPressed: () => context.read<NewsCubit>().getNews(),
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.primaryColor,
            ),
            child: const Text(
              "إعادة المحاولة",
              style: TextStyle(
                fontFamily: "Noto Kufi Arabic",
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsListView(List<News> newsList) {
    final newsModelList = newsList.map(_convertNewsToNewsModel).toList();
    
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 10.h),
      itemCount: newsList.length,
      itemBuilder: (context, index) {
        final newsModel = newsModelList[index];
        return _buildNewsCard(newsModel, newsModelList, index, newsList);
      },
    );
  }

  Widget _buildNewsCard(
    NewsModel newsModel, 
    List<NewsModel> allNewsModels, 
    int index, 
    List<News> originalNewsList
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: MyColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Image section (right side)
            _buildNewsImage(newsModel.mainImage),
            
            // Content section (left side)
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      newsModel.title,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Noto Kufi Arabic",
                        color: MyColors.softBlackColor,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      newsModel.content,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Noto Kufi Arabic",
                        color: MyColors.greyColor,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            newsModel.createdAt != null
                                ? "${newsModel.createdAt!.day} ${_months[newsModel.createdAt!.month - 1]}, ${newsModel.createdAt!.year}"
                                : "تاريخ غير متاح",
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Noto Kufi Arabic",
                              color: const Color(0xffAAAAAB),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => NewsDetails(
                                  news: originalNewsList[index],
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "عرض المزيد",
                            style: TextStyle(
                              fontSize: 9.sp,
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsImage(String imageUrl) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(12),
        bottomRight: Radius.circular(12),
      ),
      child: imageUrl.isNotEmpty
          ? Image.network(
              imageUrl,
              width: 120.w,
              height: 120.h,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _buildImagePlaceholder(),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return _buildImagePlaceholder();
              },
            )
          : _buildImagePlaceholder(),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      width: 120.w,
      height: 120.h,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Icon(
        Icons.image_not_supported,
        size: 40,
        color: Colors.grey[500],
      ),
    );
  }

  Widget _buildCircle(
    String percentText,
    String label,
    double percent,
    List<Color> gradientColors, {
    Color textColor = const Color(0xFFAAAAAB),
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularPercentIndicator(
          radius: 35.r,
          lineWidth: 6.0,
          percent: percent,
          center: Text(
            percentText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
              color: textColor,
            ),
          ),
          linearGradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          backgroundColor: Colors.grey.shade300,
          circularStrokeCap: CircularStrokeCap.round,
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
            fontFamily: 'Noto Kufi Arabic',
            color: textColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}