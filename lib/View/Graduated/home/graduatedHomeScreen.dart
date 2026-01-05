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
import '../../Student/Profile/ProfileScreen.dart';

class GraduatedHomeScreen extends StatefulWidget {
  static const String routeName = 'gradhome';

  @override
  State<GraduatedHomeScreen> createState() => _GraduatedHomeScreenState();
}

class _GraduatedHomeScreenState extends State<GraduatedHomeScreen> {
  int _currentIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  final List<String> _months = [
    'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
    'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر',
  ];

  @override
  void initState() {
    super.initState();
    context.read<NewsCubit>().getNews();
    context.read<TemplateCubit>().getTemplates();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Helper method to convert News to NewsModel
  NewsModel _convertNewsToNewsModel(News news) {
    return NewsModel(
      title: news.title,
      content: news.content,
      mainImage: news.mainImage,
      images: news.images,
      createdAt: news.createdAt,
    );
  }

  // Get current page widget
  Widget _getCurrentPage() {
    switch (_currentIndex) {
      case 0:
        return _buildGraduatedContent();
      case 1:
        return TrainingPage();
      case 2:
        return Container(child: Center(child: Text('التدريبات')));
      case 3:
        return Container(child: Center(child: Text('Dashboard')));
      default:
        return _buildGraduatedContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        body: Column(
          children: [
            if (_currentIndex != 1) 
              CommonTopSearchBar(controller: _searchController),
            Expanded(child: _getCurrentPage()),
          ],
        ),
        bottomNavigationBar: _currentIndex != 1
            ? BottomNavigation(
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              )
            : null,
      ),
    );
  }

  Widget _buildGraduatedContent() {
    return SingleChildScrollView(
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
          SizedBox(height: 40.h),
          _buildNewsHeader(),
          SizedBox(height: 20.h),
          _buildNewsList(),
        ],
      ),
    );
  }

  // بطاقة إحصائيات الخريجين
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
                    [MyColors.pnkcolor, Color(0xff14B8A6)]),
                _buildCircle("66%", "موظف", 0.66, 
                    [Color(0xffDA9240), MyColors.pnkcolor2]),
                _buildCircle("85%", "عامل حر", 0.85, 
                    [Color(0xff7563E7), MyColors.pnkcolor2]),
                _buildCircle("90%", "دراسات عليا", 0.90, 
                    [Color(0xffFBAA95), MyColors.pnkcolor2]),
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
        Spacer(),
        SvgPicture.asset('assets/images/Rectangle.svg'),
      ],
    );
  }

  // بطاقة التدريب
  Widget _buildTrainingCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: MyColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "تدريب في تحليل البيانات",
            style: TextStyle(
              fontFamily: "Noto Kufi Arabic",
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: MyColors.blackColor,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            "تعلم أساسيات تحليل البيانات باستخدام Python وExcel تعلم أساسيات تحليل البيانات باستخدام Python وExcel",
            style: TextStyle(
              fontFamily: "Noto Kufi Arabic",
              fontWeight: FontWeight.w500,
              fontSize: 10.sp,
              color: MyColors.textColor,
            ),
          ),
          SizedBox(height: 15.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildTrainingDetails(null)),
              SizedBox(width: 12.w),
              SvgPicture.asset('assets/images/Mobile.svg'),
            ],
          ),
          SizedBox(height: 20.h),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 12.h),
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
    );
  }

  Widget _buildTrainingDetails(Template? template) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow(
          'assets/images/location.svg', 
          template?.location ?? "القاهرة - مدينة نصر"
        ),
        SizedBox(height: 10.h),
        _buildDetailRow(
          'assets/images/calendar.svg', 
          template != null && template.startDate != null && template.endDate != null
              ? "${_formatDate(template.startDate!)} – ${_formatDate(template.endDate!)}"
              : "١٥ أكتوبر ٢٠٢٥ – ١٥ نوفمبر ٢٠٢٥"
        ),
        SizedBox(height: 10.h),
        _buildDetailRow(
          'assets/images/building.svg', 
          template?.companyName ?? "Wenu Start up"
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

  // رأس قسم الأخبار
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
              MaterialPageRoute(builder: (context) => AllNews()),
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

  // قائمة الأخبار
  Widget _buildNewsList() {
    return SizedBox(
      height: 150.h,
      child: BlocBuilder<NewsCubit, NewsStates>(
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
          return SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: Colors.red, size: 40),
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
            child: Text(
              "إعادة المحاولة",
              style: TextStyle(fontFamily: "Noto Kufi Arabic"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsListView(List<News> newsList) {
    final newsModelList = newsList.map(_convertNewsToNewsModel).toList();
    
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: newsList.length,
      itemBuilder: (context, index) {
        final newsModel = newsModelList[index];
        return _buildNewsCard(newsModel, newsModelList, index);
      },
    );
  }

  Widget _buildNewsCard(NewsModel newsModel, List<NewsModel> allNews, int index) {
    return Container(
      width: 343.w,
      margin: EdgeInsets.only(left: 10.w, right: index == 0 ? 10.w : 0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          color: MyColors.whiteColor,
          child: Row(
            children: [
              _buildNewsImage(newsModel.mainImage),
              SizedBox(width: 12.w),
              Expanded(child: _buildNewsContent(newsModel, allNews, index)),
            ],
          ),
          linearGradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          backgroundColor: Colors.grey.shade300,
          circularStrokeCap: CircularStrokeCap.round,
        ),
      ),
    );
  }

  Widget _buildNewsImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
      child: imageUrl.isNotEmpty
          ? Image.network(
              imageUrl,
              width: 120.w,
              height: 100.h,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _buildImagePlaceholder(),
            )
          : _buildImagePlaceholder(),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      width: 120.w,
      height: 100.h,
      color: Colors.grey[300],
      child: Icon(Icons.image_not_supported, size: 30),
    );
  }

  Widget _buildNewsContent(NewsModel newsModel, List<NewsModel> allNews, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10.h, right: 8.w),
          child: Text(
            newsModel.title,
            style: TextStyle(
              fontSize: 9.sp,
              fontWeight: FontWeight.w500,
              fontFamily: "Noto Kufi Arabic",
              color: MyColors.blackColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 8.w, bottom: 8.h),
          child: Text(
            newsModel.content.length > 50
                ? "${newsModel.content.substring(0, 50)}..."
                : newsModel.content,
            style: TextStyle(
              fontSize: 7.sp,
              fontFamily: "Noto Kufi Arabic",
              color: MyColors.greyColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        _buildNewsFooter(newsModel, allNews, index),
      ],
    );
  }

  Widget _buildNewsFooter(NewsModel newsModel, List<NewsModel> allNews, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: Text(
            newsModel.createdAt != null
                ? "${newsModel.createdAt!.day} ${_months[newsModel.createdAt!.month - 1]}, ${newsModel.createdAt!.year}"
                : "تاريخ غير متاح",
            style: TextStyle(
              fontSize: 7.sp,
              fontWeight: FontWeight.w500,
              fontFamily: "Noto Kufi Arabic",
              color: Color(0xffAAAAAB),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.w),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NewsDetails(
                    newsList: allNews,
                    initialIndex: index,
                  ),
                ),
              );
            },
            child: Text(
              "معرفة المزيد",
              style: TextStyle(
                fontSize: 7.sp,
                fontWeight: FontWeight.w500,
                fontFamily: "Noto Kufi Arabic",
                color: Color(0xff14B8A6),
              ),
            ),
          ),
        ),
      ],
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