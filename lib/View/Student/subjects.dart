



// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_college/View/widgets/common_top_search_bar.dart';
import 'package:smart_college/Models/Response/subject_model.dart';
import 'package:smart_college/Cubits/lectures/LectureCubit.dart';
import 'package:smart_college/Cubits/lectures/lectureState.dart';
import 'package:smart_college/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';


class Subjects_Screen extends StatefulWidget {
  static const String routeName = 'subjectsScreen';
  const Subjects_Screen({super.key});

  @override
  State<Subjects_Screen> createState() => Subjects_ScreenState();
}

class Subjects_ScreenState extends State<Subjects_Screen> {
  // Track expanded state for each subject week
  Map<String, bool> expandedWeeks = {};

  @override
  void initState() {
    super.initState();
    // Fetch lectures from API when screen loads
    context.read<LectureCubit>().getLectures();
  }

  // Group lectures by subject name and week number
  Map<String, Map<int, List<LectureModel>>> _getGroupedLectures(List<LectureModel> lectures) {
    Map<String, Map<int, List<LectureModel>>> grouped = {};
    for (var lecture in lectures) {
      grouped.putIfAbsent(lecture.subName, () => {});
      grouped[lecture.subName]!.putIfAbsent(lecture.numOfWeek, () => []);
      grouped[lecture.subName]![lecture.numOfWeek]!.add(lecture);
    }
    return grouped;
  }

  // Format week number to Arabic string
  String _getWeekString(int weekNumber) {
    const weeks = [
      'الأول', 'الثاني', 'الثالث', 'الرابع', 'الخامس', 'السادس', 'السابع', 'الثامن', 'التاسع', 'العاشر',
      'الحادي عشر', 'الثاني عشر', 'الثالث عشر', 'الرابع عشر', 'الخامس عشر', 'السادس عشر', 'السابع عشر', 'الثامن عشر', 'التاسع عشر', 'العشرون'
    ];
    if (weekNumber > 0 && weekNumber <= weeks.length) {
      return 'الأسبوع ${weeks[weekNumber - 1]}';
    }
    return 'الأسبوع $weekNumber';
  }

  // Format date to Arabic format
  String _formatDate(DateTime date) {
    final months = [
      'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
      'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'
    ];
    return '${date.day} ${months[date.month - 1]}, ${date.year}';
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.scaffoldcolor,
      body: Column(
        children: [
          CommonTopSearchBar(),
          Expanded(
            child: BlocConsumer<LectureCubit, LectureState>(
              listener: (context, state) {
                // Handle side effects if needed (snackbars, navigation, etc.)
              },
              builder: (context, state) {
                if (state is LectureLoading) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 50.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: MyColors.primaryColor,
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            'جاري تحميل المحاضرات...',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'Noto Kufi Arabic',
                              color: MyColors.greyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (state is LectureError) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 20.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 50.sp,
                            color: Colors.red,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'فشل في تحميل المحاضرات',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Noto Kufi Arabic',
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            state.message,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[600],
                              fontFamily: 'Noto Kufi Arabic',
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16.h),
                          ElevatedButton(
                            onPressed: () {
                              context.read<LectureCubit>().getLectures();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.primaryColor,
                              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                            ),
                            child: Text(
                              'إعادة المحاولة',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: 'Noto Kufi Arabic',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (state is LectureSuccess) {
                  final lectures = state.lectures;
                  if (lectures.isEmpty) {
                    return Center(
                      child: Text(
                        'لا توجد محاضرات متاحة',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: 'Noto Kufi Arabic',
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }
                  
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
                        // Display lectures grouped by subject and week
                        ..._getGroupedLectures(lectures).entries.map((subjectEntry) {
                          String subName = subjectEntry.key;
                          var weeksMap = subjectEntry.value;
                          
                          return Column(
                            children: [
                              // Subject Title
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                                child: Text(
                                  'مادة: $subName',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Noto Kufi Arabic',
                                  ),
                                ),
                              ),
                              // Weeks for this subject
                              ...weeksMap.entries.map((weekEntry) {
                                int weekNum = weekEntry.key;
                                List<LectureModel> weekLectures = weekEntry.value;
                                
                                // Get date from first lecture in the week
                                String dateStr = weekLectures.isNotEmpty 
                                    ? _formatDate(weekLectures.first.date)
                                    : '';
                                
                                return _buildWeekCard(
                                  weekNumber: _getWeekString(weekNum),
                                  date: dateStr,
                                  lectures: weekLectures,
                                );
                              }).toList(),
                              SizedBox(height: 24.h),
                            ],
                          );
                        }).toList(),
                        SizedBox(height: 80.h),
                      ],
                    ),
                  );
                }
                
                // Initial state
                return Center(
                  child: Text(
                    'جاري التحميل...',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'Noto Kufi Arabic',
                      color: Colors.grey,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekCard({
    required String weekNumber,
    required String date,
    required List<LectureModel> lectures,
  }) {
    final String weekKey = '${weekNumber}_$date';
    final bool isExpanded = expandedWeeks[weekKey] ?? false;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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
        children: [
          // Week Header
          InkWell(
            onTap: () {
              setState(() {
                expandedWeeks[weekKey] = !isExpanded;
              });
            },
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  // Expand/Collapse Icon
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: Color(0xFF00BFA5),
                    size: 24.sp,
                  ),
                  SizedBox(width: 12.w),
                  
                  // Week Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          weekNumber,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Noto Kufi Arabic',
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          date,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey,
                            fontFamily: 'Noto Kufi Arabic',
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(width: 12.w),
                  
                  // Book Icon
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      color: Color(0xFF00BFA5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.menu_book,
                      color: Colors.white,
                      size: 24.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Expandable Content - Display lectures from API
          if (isExpanded && lectures.isNotEmpty)
            ...lectures.map((lecture) => _buildLectureContent(lecture)).toList(),
        ],
      ),
    );
  }

  // Build lecture content using data from API (LectureModel)
  Widget _buildLectureContent(LectureModel lecture) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Divider(height: 1),
          SizedBox(height: 16.h),
          
          // Lecture Info
          Text(
            'محاضرة - ${lecture.subName}',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'Noto Kufi Arabic',
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'تاريخ: ${_formatDate(lecture.date)}',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[600],
              fontFamily: 'Noto Kufi Arabic',
            ),
          ),
          SizedBox(height: 12.h),
          
          // PDF Files from API
          if (lecture.pdfs.isNotEmpty) ...[
            Text(
              'ملفات PDF:',
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.grey[600],
                fontFamily: 'Noto Kufi Arabic',
              ),
            ),
            SizedBox(height: 8.h),
            ...lecture.pdfs.map((pdf) => _buildFileItem(
              pdf.name,
              Icons.picture_as_pdf,
              pdf.url,
            )).toList(),
            SizedBox(height: 12.h),
          ],

          // Video from API
          Text(
            'تسجيل المحاضرة:',
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey[600],
              fontFamily: 'Noto Kufi Arabic',
            ),
          ),
          SizedBox(height: 8.h),
          _buildFileItem(
            lecture.video.name,
            Icons.play_circle_outline,
            lecture.video.url,
          ),
        ],
      ),
    );
  }

  Widget _buildFileItem(String fileName, IconData icon, String url) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            icon,
            color: Color(0xFF00BFA5),
            size: 20.sp,
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: () => launchUrl(Uri.parse(url)),
            child: Text(
              fileName,
              style: TextStyle(
                fontSize: 13.sp,
                color: Color(0xFF00BFA5),
                fontFamily: 'Noto Kufi Arabic',
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}



