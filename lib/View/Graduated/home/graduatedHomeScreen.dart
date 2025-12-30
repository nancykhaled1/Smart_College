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
import 'package:smart_college/Models/Response/newsModel.dart';
import 'package:smart_college/Models/Response/news_model.dart';
import 'package:smart_college/View/Graduated/home/all_news.dart';
import 'package:smart_college/View/Graduated/home/news_datails.dart';

class GraduatedHomeScreen extends StatefulWidget {
  static const String routeName = 'gradhome';

  @override
  State<GraduatedHomeScreen> createState() => _GraduatedHomeScreenState();
}

class _GraduatedHomeScreenState extends State<GraduatedHomeScreen> {
  int _currentIndex = 0;
  TextEditingController _searchController = TextEditingController();
  late List<Widget> _pages;

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
  void initState() {
    super.initState();
    // قائمة الصفحات في الـ Bottom Navigation
    _pages = [
      GraduatedHomeScreen(),
      TrainingPage(), // المحتوى الحالي للخريجين
      
      Container(child: Center(child: Text('التدريبات'))),
      Container(child: Center(child: Text('Dashboard'))),
    ];
    // Fetch news when screen loads
    context.read<NewsCubit>().getNews();
  }

  // Helper method to convert News (from API) to NewsModel (for graduation screens)
  NewsModel _convertNewsToNewsModel(News news) {
    return NewsModel(
      title: news.title,
      content: news.content,
      mainImage: news.mainImage,
      images: news.images,
      createdAt: news.createdAt,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // هنا بتتحكمى هل ترجعى ولا لا
        return false; // ❌ مش هيرجع
        // return true;  ✅ هيرجع
      },
      child: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        body: Column(
          children: [
            // شريط البحث والإشعارات - مشترك في جميع الصفحات
            CommonTopSearchBar(controller: _searchController),

            // محتوى الصفحات
            Expanded(child: _pages[_currentIndex]),
          ],
        ),

        // Bottom Navigation Bar
        bottomNavigationBar: CommonBottomNavigation(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  // دالة لبناء محتوى الخريجين
  Widget _buildGraduatedContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200.h,
            width: 400.w,
            decoration: BoxDecoration(
              color: MyColors.whiteColor,
              //   border: Border.all(color: Colors.blue, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Row(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/images/graduation-cap.svg',
                      ),
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
                ),
                SizedBox(height: 20.h),
               Expanded(
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     _buildCircle(
                       "30%", 
                       "باحث عن عمل", 
                       0.9, 
                       [MyColors.pnkcolor, Color(0xff14B8A6)],
                       textColor: Color(0xFFAAAAAB), // لون النص
                     ),
                   //  SizedBox(width:5.h ), // مسافة
                     _buildCircle(
                       "66%", 
                       "موظف", 
                       0.85, 
                       [Color(0xffDA9240), MyColors.pnkcolor2],
                       textColor: Color(0xFFAAAAAB),
                     ),
                    // SizedBox(width: 4), // مسافة
                     _buildCircle(
                       "85%", 
                       "عامل حر", 
                       0.66, 
                       [Color(0xff7563E7), MyColors.pnkcolor2],
                       textColor: Color(0xFFAAAAAB),
                     ),
                    // SizedBox(width: 16), // مسافة
                     _buildCircle(
                       "90%", 
                       "دراسات عليا", 
                       0.30, 
                       [Color(0xffFBAA95), MyColors.pnkcolor2],
                       textColor: Color(0xFFAAAAAB),
                     ),
                   ],
                 ),
               )

              ],
            ),
          ),
          SizedBox(height: 24.h),
          Container(
  width: 345.w,
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
      /// الصف الأول: الأيقونة على الشمال والنصوص على اليمين
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// الأيقونة
          // SvgPicture.asset(
          //   'assets/images/Mobile.svg',
          //   width: 60.w,
          //   height: 60.h,
          // ),
          SizedBox(width: 10.w),

          /// النصوص
          Expanded(
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
              ],
            ),
          ),
        ],
      ),

      SizedBox(height: 15.h),

      /// باقي التفاصيل
      
               Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    /// الصورة على الشمال
    

    SizedBox(width: 12.w),

    /// العمود اللي فيه الأربع صفوف
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/images/location.svg'),
              SizedBox(width: 5.w),
              Text(
                "القاهرة - مدينة نصر",
                style: TextStyle(
                  fontFamily: "Noto Kufi Arabic",
                  fontWeight: FontWeight.w500,
                  fontSize: 10.sp,
                  color: MyColors.greyColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),

          Row(
            children: [
              SvgPicture.asset('assets/images/calendar.svg'),
              SizedBox(width: 5.w),
              Text(
                "١٥ أكتوبر ٢٠٢٥ – ١٥ نوفمبر ٢٠٢٥",
                style: TextStyle(
                  fontFamily: "Noto Kufi Arabic",
                  fontWeight: FontWeight.w500,
                  fontSize: 10.sp,
                  color: MyColors.greyColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),

          Row(
            children: [
              SvgPicture.asset('assets/images/building.svg'),
              SizedBox(width: 5.w),
              Text(
                "Wenu Start up",
                style: TextStyle(
                  fontFamily: "Noto Kufi Arabic",
                  fontWeight: FontWeight.w500,
                  fontSize: 10.sp,
                  color: MyColors.greyColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),

          Row(
            children: [
              SvgPicture.asset('assets/images/map.svg'),
              SizedBox(width: 5.w),
              Text(
                "View in Map",
                style: TextStyle(
                  fontFamily: "Noto Kufi Arabic",
                  fontWeight: FontWeight.w500,
                  fontSize: 10.sp,
                  color: MyColors.greyColor,
                ),
              ),
          
// Container(
//       width: 60.w,
//       height: 80.h,
//       child: SvgPicture.asset("assets/images/Mobile.svg",  fit: BoxFit.contain,),
      
//       ),
    
            ],
            
          ),
        ],
      ),
    ),
  ],
),


      SizedBox(height: 20.h),

      /// زر التقديم
      ElevatedButton(
        onPressed: () {},
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
),
SizedBox(height: 10.h),
                   Divider(
                    //height:343.w,
                    color: MyColors.greyColor.withOpacity(0.5),
                    thickness: .5,),
                     SizedBox(height: 40.h),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Padding(
                           padding: const EdgeInsets.only(right: 15.0),
                           child: Text(
                                      "  احدث الفعاليات و الاخبار",
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Noto Kufi Arabic",
                                        color: MyColors.blackColor,
                                      ),
                                      overflow: TextOverflow.ellipsis, // لو النص طول
                                    ),
                         ),

                   SizedBox(width: 30 .h),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => AllNews()),
                                      );
                                     },
                                    child: Text(
                                      "    عرض كل الاخبار",
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Noto Kufi Arabic",
                                        color: MyColors.primaryColor,
                                      ),
                                      overflow: TextOverflow.ellipsis, // لو النص طول
                                    ),
                                  ),
                       ],
                     ),
 //SizedBox(height:  .h),
  SizedBox(
    height: 400.h,
    child: BlocBuilder<NewsCubit, NewsStates>(
      builder: (context, state) {
        if (state is NewsLoadingState) {
          return Center(
            child: CircularProgressIndicator(
              color: MyColors.primaryColor,
            ),
          );
        } else if (state is NewsErrorState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, color: Colors.red, size: 40),
                SizedBox(height: 10.h),
                Text(
                  state.errorMessage ?? "حدث خطأ",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: "Noto Kufi Arabic",
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                ElevatedButton(
                  onPressed: () {
                    context.read<NewsCubit>().getNews();
                  },
                  child: Text("إعادة المحاولة", style: TextStyle(fontFamily: "Noto Kufi Arabic")),
                ),
              ],
            ),
          );
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
          // Convert all news to NewsModel list
          final newsModelList = newsList.map((news) => _convertNewsToNewsModel(news)).toList();
          
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: newsList.length,
            itemBuilder: (context, index) {
              final news = newsList[index];
              final newsModel = _convertNewsToNewsModel(news);
              return Container(
                width: 343.w,
                margin: EdgeInsets.only(left: index == 0 ? 0 : 10.w, right: 10.w),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    color: MyColors.whiteColor,
                    child: Row(
                      children: [
                        // News Image
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          child: newsModel.mainImage.isNotEmpty
                              ? Image.network(
                                  newsModel.mainImage,
                                  width: 120.w,
                                  height: 100.h,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 120.w,
                                      height: 100.h,
                                      color: Colors.grey[300],
                                      child: Icon(Icons.image_not_supported, size: 30),
                                    );
                                  },
                                )
                              : Container(
                                  width: 120.w,
                                  height: 100.h,
                                  color: Colors.grey[300],
                                  child: Icon(Icons.image_not_supported, size: 30),
                                ),
                        ),
                        SizedBox(width: 12),
                        // News Content
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10, right: 8),
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
                                padding: const EdgeInsets.only(right: 8, bottom: 8),
                                child: Text(
                                  newsModel.content.length > 50 
                                      ? newsModel.content.substring(0, 50) + "..."
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
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
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => NewsDetails(
                                              newsList: newsModelList,
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
        return SizedBox.shrink();
      },
    ),
  ),
        ],
      ),
    );
  }

 Widget _buildCircle(
  String percentText,
  String label,
  double percent,
  List<Color> gradientColors, {
  Color textColor = const Color(0xFFAAAAAB), // لون النص الافتراضي
}) {
  return Column(
    children: [
      CircularPercentIndicator(
        radius: 40.0,
        lineWidth: 6.0,
        percent: percent,
        center: Text(
          percentText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: textColor, // لون النسبة
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
      SizedBox(height: 8),
      Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textColor, // لون اللابل
        ),
      ),
    ],
  );
}

}