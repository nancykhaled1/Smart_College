import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:smart_college/View/Student/Home/StudentHomeScreen.dart';
import 'package:smart_college/View/Student/Materials&Exams/ExamDialog.dart';
import 'package:smart_college/View/home/homeScreen.dart';
import 'package:smart_college/utils/colors.dart';

import '../../../Cubits/States/States.dart';
import '../../../Cubits/Students/ExamsScreenViewModel.dart';
import 'AttemptCard.dart';

class Examscreen extends StatefulWidget {
  static const String routeName = 'exams';

  @override
  State<Examscreen> createState() => _ExamscreenState();
}

class _ExamscreenState extends State<Examscreen> {
  @override
  void initState() {
    super.initState();
    context.read<ExamsScreenViewModel>().getExamsAndAttempts();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          // هنا بتتحكمى هل ترجعى ولا لا
          return false; // ❌ مش هيرجع
          // return true;  ✅ هيرجع
        },
        child: Scaffold(
          backgroundColor: MyColors.backgroundColor,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: BlocBuilder<ExamsScreenViewModel, States>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: MyColors.primaryColor,
                    ),
                  );
                } else if (state is ErrorState) {
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
                } else if (state is ExamsAndAttemptsState) {

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ✅ الامتحانات المتاحة
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(
                          'الامتحانات المتاحة حاليا',
                          style: TextStyle(
                            fontFamily: 'Noto Kufi Arabic',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: MyColors.blackColor,
                          ),
                        ),
                      ),
                      state.exams.isEmpty
                          ? Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 30.h),
                          child: Text(
                            'لا توجد امتحانات متاحة حاليًا',
                            style: TextStyle(
                              fontFamily: 'Noto Kufi Arabic',
                              fontSize: 14.sp,
                              color: MyColors.greyColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                          :
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.exams.length,
                          itemBuilder: (context, index) {
                            final exam = state.exams[index];
                            final DateTime parsedDate =
                                DateTime.parse(exam.updatedAt ?? '').toLocal();
                            final String formattedDate = DateFormat(
                              'HH:mm – dd/MM/yyyy',
                            ).format(parsedDate);
                            final examCubit = context.read<ExamsScreenViewModel>();
                            // examCubit.getQuestions(exam.id!);
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.all(10.r),
                              decoration: BoxDecoration(
                                color: MyColors.whiteColor,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: MyColors.greyColor,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/images/quiz.svg',
                                    ),
                                  ),
                                  SizedBox(width: 15.h),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        exam.title ?? '',
                                        style: TextStyle(
                                          fontFamily: 'Noto Kufi Arabic',
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color: MyColors.softBlackColor,
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      Text(
                                        formattedDate,
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
                                  TextButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        barrierDismissible:
                                            false, // لا يمكن اغلاق الديالوج بالضغط بالخارج
                                        builder:
                                            (_) => WillPopScope(
                                              onWillPop:
                                                  () async =>
                                                      false, // يمنع زر الرجوع أيضاً
                                              child: ExamDialog(
                                                examId: exam.id ?? '',
                                                noOfQuestions: examCubit.questions.length
                                              ),
                                            ),
                                      );
                                    },
                                    child: Text(
                                      'ابدا الان',
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
                          },
                        ),
                      ),
                      // ✅ الامتحانات السابقة
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(
                          'الامتحانات السابقة',
                          style: TextStyle(
                            fontFamily: 'Noto Kufi Arabic',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: MyColors.blackColor,
                          ),
                        ),
                      ),
                      state.attempts.isEmpty
                          ? Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 30.h),
                          child: Text(
                            'لا توجد امتحانات سابقة',
                            style: TextStyle(
                              fontFamily: 'Noto Kufi Arabic',
                              fontSize: 14.sp,
                              color: MyColors.greyColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                          :
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.attempts.length,
                          itemBuilder: (context, index) {
                            final attempt = state.attempts[index];


                            return ExamCard(
                              attempt: attempt,
                              // id:attempt.exam!.id! ,
                              // examName: attempt.exam?.title ?? '',
                              // date: formattedDate,
                              // current: attempt.correctCount!,
                              // total: attempt.totalPoints!,
                              // maxPoints : attempt.maxPoints
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildErrorWidget(String error) {
    if (error == "No Internet Connection") {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/no_internet.png",
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
        ),
      );
    } else {
      return Center(
        child: Text(
          "حدث خطأ غير متوقع، حاول مرة أخرى لاحقاً",
          style: TextStyle(color: MyColors.greyColor, fontSize: 16.sp),
        ),
      );
    }
  }
}
