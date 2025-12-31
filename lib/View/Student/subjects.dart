// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  // Track expanded state for each week
  Map<String, bool> expandedWeeks = {};

  @override
  void initState() {
    super.initState();
    context.read<LectureCubit>().getLectures();
  }

  // Group lectures by subject name and week number
  Map<String, Map<int, List<LectureModel>>> _getGroupedLectures(
      List<LectureModel> lectures) {
    Map<String, Map<int, List<LectureModel>>> grouped = {};
    for (var lecture in lectures) {
      grouped.putIfAbsent(lecture.subName, () => {});
      grouped[lecture.subName]!.putIfAbsent(lecture.numOfWeek, () => []);
      grouped[lecture.subName]![lecture.numOfWeek]!.add(lecture);
    }
    return grouped;
  }

  // Format week number to Arabic
  String _getWeekString(int weekNumber) {
    const weeks = [
      'الأول',
      'الثاني',
      'الثالث',
      'الرابع',
      'الخامس',
      'السادس',
      'السابع',
      'الثامن',
      'التاسع',
      'العاشر',
      'الحادي عشر',
      'الثاني عشر',
      'الثالث عشر',
      'الرابع عشر',
      'الخامس عشر'
    ];
    if (weekNumber > 0 && weekNumber <= weeks.length) {
      return 'الأسبوع ${weeks[weekNumber - 1]}';
    }
    return 'الأسبوع $weekNumber';
  }

  // Format date
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'المواد الدراسية',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Noto Kufi Arabic',
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocConsumer<LectureCubit, LectureState>(
        listener: (context, state) {
          // Handle side effects if needed
        },
        builder: (context, state) {
          if (state is LectureLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Color(0xFF00BFA5),
              ),
            );
          } else if (state is LectureError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 60.sp, color: Colors.red),
                  SizedBox(height: 16.h),
                  Text(
                    'حدث خطأ في تحميل البيانات',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: 'Noto Kufi Arabic',
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    state.message,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey,
                      fontFamily: 'Noto Kufi Arabic',
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    onPressed: () {
                      context.read<LectureCubit>().getLectures();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF00BFA5),
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.w,
                        vertical: 12.h,
                      ),
                    ),
                    child: Text(
                      'إعادة المحاولة',
                      style: TextStyle(
                        fontFamily: 'Noto Kufi Arabic',
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
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

            final groupedLectures = _getGroupedLectures(lectures);

            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              itemCount: groupedLectures.length,
              itemBuilder: (context, index) {
                final subjectEntry = groupedLectures.entries.elementAt(index);
                final subjectName = subjectEntry.key;
                final weeksMap = subjectEntry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Subject Header
                    Padding(
                      padding: EdgeInsets.only(bottom: 12.h, right: 8.w),
                      child: Text(
                        'مادة: $subjectName',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Noto Kufi Arabic',
                          color: Colors.black87,
                        ),
                      ),
                    ),

                    // Weeks for this subject
                    ...weeksMap.entries.map((weekEntry) {
                      final weekNum = weekEntry.key;
                      final weekLectures = weekEntry.value;
                      final weekKey = '${subjectName}_week_$weekNum';
                      final isExpanded = expandedWeeks[weekKey] ?? false;

                      // Get first lecture for date
                      final firstLecture = weekLectures.first;
                      final dateStr = _formatDate(firstLecture.date);

                      return _buildWeekCard(
                        weekKey: weekKey,
                        weekNumber: _getWeekString(weekNum),
                        date: dateStr,
                        isExpanded: isExpanded,
                        lecture: firstLecture,
                      );
                    }).toList(),

                    SizedBox(height: 24.h),
                  ],
                );
              },
            );
          }

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
    );
  }

  Widget _buildWeekCard({
    required String weekKey,
    required String weekNumber,
    required String date,
    required bool isExpanded,
    required LectureModel lecture,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
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
            borderRadius: BorderRadius.circular(12.r),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  // Expand/Collapse Icon
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Color(0xFF00BFA5),
                    size: 24.sp,
                  ),
                  
                  SizedBox(width: 16.w),

                  // Week Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          weekNumber,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Noto Kufi Arabic',
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          date,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[600],
                            fontFamily: 'Noto Kufi Arabic',
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 16.w),

                  // Book Icon
                  Container(
                    width: 50.w,
                    height: 50.w,
                    decoration: BoxDecoration(
                      color: Color(0xFF00BFA5),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.menu_book_rounded,
                      color: Colors.white,
                      size: 26.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Expandable Content
          if (isExpanded) _buildExpandedContent(lecture),
        ],
      ),
    );
  }

  Widget _buildExpandedContent(LectureModel lecture) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Divider
          Divider(height: 1, color: Colors.grey[200]),
          SizedBox(height: 16.h),

          // Title
          Text(
            'العنوان: ${lecture.video.name.split('.').first}',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'Noto Kufi Arabic',
              color: Colors.black87,
            ),
            textAlign: TextAlign.right,
          ),

          SizedBox(height: 16.h),

          // PDF Files Section
          if (lecture.pdfs.isNotEmpty) ...[
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'ملفات المحاضرة:',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                  fontFamily: 'Noto Kufi Arabic',
                ),
              ),
            ),
            SizedBox(height: 12.h),

            // PDF Files List
            ...lecture.pdfs.asMap().entries.map((entry) {
              final index = entry.key;
              final pdf = entry.value;
              final fileName = pdf.name.split('.').first;

              return _buildFileItem(
                fileName: fileName,
                icon: Icons.cloud_download_outlined,
                fileUrl: pdf.url,
                isLast: index == lecture.pdfs.length - 1,
              );
            }).toList(),

            SizedBox(height: 16.h),
          ],

          // Video Recording Section
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'تسجيل المحاضرة:',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
                fontFamily: 'Noto Kufi Arabic',
              ),
            ),
          ),
          SizedBox(height: 12.h),

          // Video File
          _buildFileItem(
            fileName: lecture.video.name.split('.').first,
            icon: Icons.play_circle_outline,
            fileUrl: lecture.video.url,
            isLast: true,
            isVideo: true,
          ),
        ],
      ),
    );
  }

  Widget _buildFileItem({
    required String fileName,
    required IconData icon,
    required String fileUrl,
    required bool isLast,
    bool isVideo = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 8.h),
      child: InkWell(
        onTap: () async {
          final uri = Uri.parse(fileUrl);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'تعذر فتح الملف',
                  style: TextStyle(fontFamily: 'Noto Kufi Arabic'),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  fileName,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Color(0xFF00BFA5),
                    fontFamily: 'Noto Kufi Arabic',
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                icon,
                color: Color(0xFF00BFA5),
                size: 20.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}