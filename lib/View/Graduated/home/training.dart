import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_college/View/widgets/common_bottom_navigation.dart';
import 'package:smart_college/View/widgets/common_top_search_bar.dart';
import 'package:smart_college/View/widgets/info_row_widget.dart'; // فيه EventInfoCard

class TrainingPage extends StatefulWidget {
  const TrainingPage({super.key});
  static const String routeName = 'trainingPage';


  @override
  State<TrainingPage> createState() => __TrainingPage();
}

class __TrainingPage extends State<TrainingPage> {

  TextEditingController _searchController = TextEditingController();
  int _currentIndex = 3; // Training
  @override 
  
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF5F5F5),

      body: SingleChildScrollView(
        child: Column(
          children: [
             CommonTopSearchBar(controller: _searchController),
        
              // محتوى الصفحات
            //  Expanded(child: _pages[_currentIndex]),
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  
                  children: [
                    
                  
                    TrainingCard(
                      title: 'تدريب في تطوير التطبيقات',
                      description:
                          'فرصة تدريبية لتعلم تطوير التطبيقات باستخدام Flutter و Dart.',
                      location: 'الرياض، السعودية',
                      startDate: '2024-07-01',
                      endDate: '2024-09-30',
                      company: 'شركة التقنية الحديثة',
                      iconPath: 'assets/icons/training.svg',
                      onApplyPressed: () {
                        // تنفيذ عند الضغط على زر التقديم
                      },
                    ),
                    SizedBox(height: 20.h),
                    TrainingCard(
                      title: 'تدريب في تحليل البيانات',
                      description:
                          'فرصة تدريبية لتعلم تحليل البيانات باستخدام Python و SQL.',
                      location: 'جدة، السعودية',
                      startDate: '2024-08-01',
                      endDate: '2024-10-31',
                      company: 'شركة البيانات الذكية',
                      iconPath: 'assets/icons/data_analysis.svg',
                      onApplyPressed: () {
                        // تنفيذ عند الضغط على زر التقديم
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CommonBottomNavigation(
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
}
