 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
  int selectedIndex = 0; // للتحكم في الزر المختار
  int  _currentIndex = 1; // Postgraduate Studies

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
      CommonTopSearchBar(),

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
  // قائمة البيانات
  final List<Map<String, String>> programs = [
    {
      'title': 'تدريب في تحليل البيانات',
      'description': 'تعلم أساسيات تحليل البيانات باستخدام Python وExcel',
      'date': '١٥ أكتوبر ٢٠٢٥ – ١٥ نوفمبر ٢٠٢٥',
      'university': 'جامعة القاهرة',
    },
    {
      'title': 'ماجستير في الذكاء الاصطناعي',
      'description': 'برنامج متقدم في تقنيات الذكاء الاصطناعي والتعلم الآلي',
      'date': '١ سبتمبر ٢٠٢٥ – ١ يونيو ٢٠٢٧',
      'university': 'الجامعة الأمريكية بالقاهرة',
    },
    {
      'title': 'دكتوراه في علوم الحاسب',
      'description': 'برنامج بحثي متقدم في مجال علوم الحاسب والبرمجة',
      'date': '١٥ سبتمبر ٢٠٢٥ – ١٥ يوليو ٢٠٢٨',
      'university': 'جامعة عين شمس',
    },
  ];

  return Column(
    children: programs.map((program) => _buildProgramCard(
      title: program['title']!,
      description: program['description']!,
      date: program['date']!,
      university: program['university']!,
    )).toList(),
  );
}

Widget _buildProgramCard({
  required String title,
  required String description,
  required String date,
  required String university,
}) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 16.h),
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
        Text(
          title,
          style: TextStyle(
            fontFamily: "Noto Kufi Arabic",
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
            color: MyColors.blackColor,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          description,
          style: TextStyle(
            fontFamily: "Noto Kufi Arabic",
            fontWeight: FontWeight.w500,
            fontSize: 10.sp,
            color: MyColors.textColor,
          ),
        ),
        SizedBox(height: 15.h),
        Row(
          children: [
            SvgPicture.asset('assets/images/calendar.svg'),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                date,
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
        SizedBox(height: 10.h),
        Row(
          children: [
            SvgPicture.asset('assets/images/building.svg'),
            SizedBox(width: 8.w),
            Text(
              university,
              style: TextStyle(
                fontFamily: "Noto Kufi Arabic",
                fontWeight: FontWeight.w500,
                fontSize: 10.sp,
                color: MyColors.greyColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
      ],
    ),
  );
}
  
}


