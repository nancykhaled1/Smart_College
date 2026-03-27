import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_college/View/widgets/build_circle_widget.dart';
import 'package:smart_college/View/widgets/common_bottom_navigation.dart';
import 'package:smart_college/View/widgets/common_top_search_bar.dart';
import 'package:smart_college/View/widgets/job_progress_widget.dart';
import 'package:smart_college/utils/colors.dart';

class DashboardPage extends StatefulWidget {
   static const String routeName = 'dashboardPage';
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  TextEditingController _searchController = TextEditingController();
  int _currentIndex = 4; // Dashboard
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CommonTopSearchBar(controller: _searchController),
            
            SizedBox(height: 12.h),
            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // عنوان الخريجين
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/graduation-cap.svg',
                          width: 24.w,
                          height: 24.h,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "الخريجين",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: MyColors.blackColor,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Noto Kufi Arabic',
                          ),
                        ),
                       Spacer(),
                        SvgPicture.asset(
                          'assets/images/Rectangle.svg',
                          width: 80.w,
                          height: 80.h,
                          fit: BoxFit.cover,
                        )
                      ],
                    ),
                    
                    SizedBox(height: 24.h),
                    
                    // ✅ الدوائر في صفين
                    Column(
                      children: [
                        // الصف الأول
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircularPercentWidget(
                              percentText: "30%",
                              label: "باحث عن عمل",
                              percent: 0.30,
                              gradientColors: [MyColors.pnkcolor, Color(0xff14B8A6)],
                              textColor: Color(0xFFAAAAAB),
                              
                            ),
                            
                            SizedBox(width: 20.w),
                            
                            CircularPercentWidget(
                              percentText: "66%",
                              label: "موظف",
                              percent: 0.66,
                              gradientColors: [Color(0xffDA9240), MyColors.pnkcolor2],
                              textColor: Color(0xFFAAAAAB),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: 24.h),
                        
                        // الصف الثاني
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircularPercentWidget(
                              percentText: "85%",
                              label: "عامل حر",
                              percent: 0.85,
                              gradientColors: [Color(0xff7563E7), MyColors.pnkcolor2],
                              textColor: Color(0xFFAAAAAB),
                            ),
                            
                            SizedBox(width: 20.w),
                            
                            CircularPercentWidget(
                              percentText: "90%",
                              label: "دراسات عليا",
                              percent: 0.90,
                              gradientColors: [Color(0xffFBAA95), MyColors.pnkcolor2],
                              textColor: Color(0xFFAAAAAB),
                            ),
                          ],
                        ),
                      ],
                    ),
                   
                  ],
                ),
              ),
             
            ),
            
                    SizedBox(height: 16.h),
                   JobProgressCard(),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigation(
      //   currentIndex: _currentIndex,
      //   onTap: (index) {
      //     if (index != _currentIndex) {
      //       String route;
      //       switch (index) {
      //         case 0:
      //           route = 'gradhome';
      //           break;
      //         case 1:
      //           route = 'postgraduatStudies';
      //           break;
      //         case 2:
      //           route = 'gradhome'; // Chat, navigate to home for now
      //           break;
      //         case 3:
      //           route = 'trainingPage';
      //           break;
      //         case 4:
      //         default:
      //           route = 'dashboardPage';
      //           break;
      //       }
      //       Navigator.pushNamed(context, route);
      //     }
      //   },
      // ),
    );
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}