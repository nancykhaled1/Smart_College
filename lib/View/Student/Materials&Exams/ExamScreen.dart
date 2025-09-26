import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:smart_college/View/Student/Home/StudentHomeScreen.dart';
import 'package:smart_college/View/Student/Materials&Exams/ExamDialog.dart';
import 'package:smart_college/utils/colors.dart';

import '../../../Cubits/States/States.dart';
import '../../../Cubits/Students/ExamsScreenViewModel.dart';

class Examscreen extends StatefulWidget{
  static const String routeName = 'exams';

  @override
  State<Examscreen> createState() => _ExamscreenState();
}

class _ExamscreenState extends State<Examscreen> {
  @override
  void initState() {
    super.initState();
    context.read<ExamsScreenViewModel>().getExams();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: MyColors.backgroundColor,
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => StudentHomeScreen(),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );

                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: MyColors.whiteColor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: MyColors.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 80.w,),
                    Text('الامتحانات',
                      style: TextStyle(
                        fontFamily: 'Noto Kufi Arabic',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: MyColors.softBlackColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50.h),
                Text('الامتحانات المتاحة حاليا',
                  style: TextStyle(
                    fontFamily: 'Noto Kufi Arabic',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: MyColors.blackColor,
                  ),
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: BlocBuilder<ExamsScreenViewModel, States>(
                    builder: (context, state) {

                      if (state is LoadingState) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: MyColors.primaryColor,
                          ),
                        );
                      }
                      else if (state is ErrorState) {
                        final error = state.errorMessage;

                        if (error == "No Internet Connection") {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/no_internet.png", // 🖼️ ضيفي صورة عندك
                                width: 200,
                                height: 200,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "لا يوجد اتصال بالانترنت",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: MyColors.greyColor,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Noto Kufi Arabic",
                                ),
                              ),
                            ],
                          );
                        }
                        else {
                          return Center(
                            child: Text(
                              "حدث خطأ غير متوقع المحاوله فى وقت لاحق",
                              style: TextStyle(
                                color: MyColors.greyColor,
                                fontSize: 16.sp,
                              ),
                            ),
                          );
                        }

                      }
                      else if (state is ExamsSuccessState) {
                        final exams = state.exams;
                        if (exams.isEmpty) {
                          return Center(
                            child: Text('لا يوجد امتحانات متاحه حاليا',
                              style: TextStyle(
                                color: MyColors.greyColor,
                                fontFamily: "Noto Kufi Arabic",
                                fontWeight: FontWeight.w500,
                                fontSize: 24.sp,
                              ),
                            ),
                          );
                        }

                        return ListView.builder(
                            itemCount: exams.length,
                            itemBuilder: (context, index) {
                              final exam = exams[index];
                              final DateTime parsedDate = DateTime.parse(exam.updatedAt ??'' ).toLocal();
                              final String formattedDate = DateFormat('HH:mm – dd/MM/yyyy').format(parsedDate);
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                padding: EdgeInsets.all(10.r),
                                decoration: BoxDecoration(
                                    color: MyColors.whiteColor,
                                    borderRadius: BorderRadius.circular(10.r)
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: MyColors.greyColor,
                                          borderRadius: BorderRadius.circular(10.r),
                                        ),
                                        child: SvgPicture.asset('assets/images/quiz.svg')
                                    ),
                                    SizedBox(width: 15.h),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(exam.title ??'',
                                          style: TextStyle(
                                            fontFamily: 'Noto Kufi Arabic',
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            color: MyColors.softBlackColor,
                                          ),
                                        ),
                                        SizedBox(height: 10.h),
                                        Text(formattedDate,
                                          style: TextStyle(
                                            fontFamily: 'Noto Kufi Arabic',
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w500,
                                            color: MyColors.greyColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    TextButton(onPressed: () {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false, // لا يمكن اغلاق الديالوج بالضغط بالخارج
                                        builder:
                                            (_) => WillPopScope(
                                          onWillPop: () async => false, // يمنع زر الرجوع أيضاً
                                          child: ExamDialog(examId: exam.id ??'',
                                          ),
                                        ),
                                      );
                                    },
                                      child: Text('ابدا الان',
                                        style: TextStyle(
                                          fontFamily: 'Noto Kufi Arabic',
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w500,
                                          color: MyColors.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                              );
                            }
                        );
                        }
                        return Container();
                      }

                  ),



                )

              ],
            ),
          ),
        )
    );
  }
}