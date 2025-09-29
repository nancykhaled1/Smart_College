import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_college/Models/Response/news_model.dart';
import 'package:smart_college/View/Student/all_news.dart';
import 'package:smart_college/View/Student/news_details.dart';
import 'package:smart_college/utils/colors.dart';
import 'package:smart_college/services/news_manager.dart';
import 'package:smart_college/View/widgets/common_top_search_bar.dart';
import 'package:smart_college/View/widgets/student_bottom_navigation.dart';



class studentHomescreen extends StatefulWidget {
  static const String routeName = 'studentHomescreen';

  const studentHomescreen({super.key});

  @override
  State<studentHomescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<studentHomescreen> {
  int _currentIndex = 0;
  TextEditingController _searchController = TextEditingController();
  late List<Widget> _pages;

  DateTime _currentDate = DateTime.now();
  
  // الحصول على آخر خبر من الخدمة
  NewsModel? currentNews;
  bool isLoading = true;

 @override
  void initState() {
    super.initState();
    // قائمة الصفحات في الـ Bottom Navigation
    _pages = [
  
      Container(child: Center(child: Text(' المواد الدراسية'))),
      Container(child: Center(child: Text('الامتحانات'))),
      Container(child: Center(child: Text('بروفايل'))),
    ];
    _loadNews();
  }

  // تحميل آخر خبر من API
  Future<void> _loadNews() async {
    try {
      final news = await NewsManager.getLatestNews();
      if (mounted) {
        setState(() {
          currentNews = news;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading news: $e');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // قائمة بالأيام باللغة العربية
  final List<String> _weekDays = [
    'SAT',
    'SUN',
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
  ];

  // قائمة بأسماء الشهور باللغة العربية
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      bottomNavigationBar: CommonBottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: Column(
        children: [
          CommonTopSearchBar(controller: _searchController),
          Expanded(
            child: SingleChildScrollView(
          child: Column(
            children: [
         

              // الكالندر
              SingleChildScrollView(child: _buildCalendar()),

              SizedBox(height: 20.h),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      " اليوم",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Noto Kufi Arabic",
                        color: MyColors.blackColor,
                      ),
                    ),
                  ),
                ],
                )
                ,
                  SizedBox(height: 10.h),
                  Container(
                    width: 343.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      color: MyColors.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 10.w),
                        SvgPicture.asset("assets/images/book-open.svg"),
                        SizedBox(width: 10.w),
                        Expanded(
                        
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                " محاضرة فيزيكس",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Noto Kufi Arabic",
                                  color: MyColors.blackColor,
                                ),
                                overflow: TextOverflow.ellipsis, // لو النص طول
                              ),
                              SizedBox(height: 5.h),
                              Text(
                            "10:00ص-11:00ص",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Noto Kufi Arabic",
                                  color: MyColors.greyColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      
                     ]
                  ),
                  ),
                   SizedBox(height: 10.h),
                  Container(
                    width: 343.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      color: MyColors.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 10.w),
                        SvgPicture.asset("assets/images/Lab.svg"),
                        SizedBox(width: 10.w),
                        Expanded(
                        
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                " محاضرة فيزيكس",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Noto Kufi Arabic",
                                  color: MyColors.blackColor,
                                ),
                                overflow: TextOverflow.ellipsis, // لو النص طول
                              ),
                              SizedBox(height: 5.h),
                              Text(
                            "10:00ص-11:00ص",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Noto Kufi Arabic",
                                  color: MyColors.greyColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      
                     ]
                  ),
                  ),
                   SizedBox(height: 10.h),
                  Container(
                    width: 343.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      color: MyColors.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 10.w),
                        SvgPicture.asset("assets/images/book-open.svg"),
                        SizedBox(width: 10.w),
                        Expanded(
                        
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                " محاضرة فيزيكس",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Noto Kufi Arabic",
                                  color: MyColors.blackColor,
                                ),
                                overflow: TextOverflow.ellipsis, // لو النص طول
                              ),
                              SizedBox(height: 5.h),
                              Text(
                            "10:00ص-11:00ص",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Noto Kufi Arabic",
                                  color: MyColors.greyColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      
                     ]
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
                                  
                   SizedBox(width: 20 .h),
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
    child: isLoading
        ? Center(child: CircularProgressIndicator())
        : currentNews != null
            ? Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  color: MyColors.whiteColor,
                  width: 350.w,
                  height: 100.h,
                  child: Row(
                    children: [
                      Expanded(
                        child: currentNews!.mainImage.isNotEmpty
                            ? Image.network(
                                currentNews!.mainImage,
                                width: 120.w,
                                height: 100.h,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 120.w,
                                    height: 100.h,
                                    color: Colors.grey[300],
                                    child: Icon(Icons.image_not_supported),
                                  );
                                },
                              )
                            : Container(
                                width: 120.w,
                                height: 100.h,
                                color: Colors.grey[300],
                                child: Icon(Icons.image_not_supported),
                              ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                currentNews!.title,
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Noto Kufi Arabic",
                                  color: MyColors.blackColor,
                                ),
                                maxLines: 2,
                                softWrap: true,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  currentNews!.createdAt != null
                                      ? "${currentNews!.createdAt!.day} ${_months[currentNews!.createdAt!.month - 1]}, ${currentNews!.createdAt!.year}"
                                      : "17 أكتوبر, 2024",
                                  style: TextStyle(
                                    fontSize: 7.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Noto Kufi Arabic",
                                    color: Color(0xffAAAAAB),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => NewsDetails(news: currentNews!),
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
              )
            : Center(
                child: Text(
                  "لا توجد أخبار متاحة",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey,
                    fontFamily: "Noto Kufi Arabic",
                  ),
                ),
              ),
  ),
                ],  

              ),
            
          ),
        
          )
    ] , 
        ),
          );
       
      
    
    
  }

  // دالة إنشاء الكالندر
  Widget _buildCalendar() {
    return Container(
      width: 342.w,
      constraints: BoxConstraints(
        minHeight: 300.h,
        maxHeight: 350.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: MyColors.blackColor.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(15.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header الكالندر
            _buildCalendarHeader(),
            SizedBox(height: 15.h),
            // أيام الأسبوع
            _buildWeekDays(),
            SizedBox(height: 10.h),
            // شبكة التواريخ
            Expanded(
              child: _buildCalendarGrid(),
            ),
          ],
        ),
      ),
    );
  }

  // Header الكالندر مع أزرار التنقل
  Widget _buildCalendarHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // زر الشهر السابق
        GestureDetector(
          onTap: () {
            setState(() {
              _currentDate = DateTime(
                _currentDate.year,
                _currentDate.month - 1,
              );
            });
          },
          child: Container(
            width: 30.w,
            height: 30.h,
            decoration: BoxDecoration(
              color: MyColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.chevron_left,
              color: MyColors.primaryColor,
              size: 20.sp,
            ),
          ),
        ),
        // اسم الشهر والسنة
        Text(
          '${_months[_currentDate.month - 1]} ${_currentDate.year}',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            fontFamily: "Noto Kufi Arabic",
            color: MyColors.blackColor,
          ),
        ),
        // زر الشهر التالي
        GestureDetector(
          onTap: () {
            setState(() {
              _currentDate = DateTime(
                _currentDate.year,
                _currentDate.month + 1,
              );
            });
          },
          child: Container(
            width: 30.w,
            height: 30.h,
            decoration: BoxDecoration(
              color: MyColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.chevron_right,
              color: MyColors.primaryColor,
              size: 20.sp,
            ),
          ),
        ),
      ],
    );
  }

  // أيام الأسبوع
  Widget _buildWeekDays() {
    return Row(
      children:
          _weekDays.map((day) {
            return Expanded(
              child: Center(
                child: Text(
                  day,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Noto Kufi Arabic",
                    color: MyColors.greyColor,
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }

  // شبكة التواريخ
  Widget _buildCalendarGrid() {
    final firstDayOfMonth = DateTime(_currentDate.year, _currentDate.month, 1);
    final lastDayOfMonth = DateTime(
      _currentDate.year,
      _currentDate.month + 1,
      0,
    );
    final firstDayWeekday =
        firstDayOfMonth.weekday % 7; // تحويل إلى نظام السبت = 0

    List<Widget> calendarDays = [];

    // إضافة الأيام الفارغة في بداية الشهر
    for (int i = 0; i < firstDayWeekday; i++) {
      calendarDays.add(Container());
    }

    // إضافة أيام الشهر
    for (int day = 1; day <= lastDayOfMonth.day; day++) {
      final date = DateTime(_currentDate.year, _currentDate.month, day);
      final isToday =
          date.day == DateTime.now().day &&
          date.month == DateTime.now().month &&
          date.year == DateTime.now().year;

      calendarDays.add(
        GestureDetector(
          onTap: () {
            // يمكن إضافة وظيفة عند الضغط على التاريخ
          },
          child: Container(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // دائرة التمييز للتواريخ المهمة
                  if (day == 1 || day == 17)
                    Container(
                      width: 28.w,
                      height: 28.h,
                      decoration: BoxDecoration(
                        color:
                            day == 1
                                ? MyColors.primaryColor
                                : MyColors.primaryColor.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                    ),
                  // رقم اليوم
                  Text(
                    '$day',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Noto Kufi Arabic",
                      color:
                          isToday
                              ? Colors.white
                              : (day == 1 || day == 17)
                              ? Colors.white
                              : MyColors.blackColor,
                    ),
                  ),
                  // نص إضافي للتاريخ 17
                  if (day == 17)
                    Positioned(
                      bottom: -8.h,
                      left: 0,
                      right: 0,
                      child: Text(
                        'بداية العام الدراسي',
                        style: TextStyle(
                          fontSize: 6.sp,
                          fontFamily: "Noto Kufi Arabic",
                          color: MyColors.greyColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1.2,
        crossAxisSpacing: 1.w,
        mainAxisSpacing: 1.h,
      ),
      itemCount: calendarDays.length,
      itemBuilder: (context, index) {
        return calendarDays[index];
      },
    );
  }
}
