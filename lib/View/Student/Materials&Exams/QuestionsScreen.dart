import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_college/utils/colors.dart';

import '../../../Cubits/States/States.dart';
import '../../../Cubits/Students/ExamDetailsViewModel.dart';
import '../../../Cubits/Students/ExamsScreenViewModel.dart';

class ExamQuestionScreen extends StatefulWidget {
  final String examId;
  final String attemptId;
  final String examName;

  const ExamQuestionScreen({super.key, required this.examId, required this.attemptId, required this.examName });

  @override
  _ExamQuestionScreenState createState() => _ExamQuestionScreenState();
}

class _ExamQuestionScreenState extends State<ExamQuestionScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ExamsScreenViewModel>().getQuestions(widget.examId);
    // 🟢 نضيف listener للـ controller
    final viewModel = context.read<ExamsScreenViewModel>();
    viewModel.shortAnswerController.addListener(() {
      setState(() {}); // يحدث الـ UI لما النص يتغير
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamsScreenViewModel, States>(
      builder: (context, state) {
        final viewModel = context.read<ExamsScreenViewModel>();

        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ErrorState) {
          return Center(child: Text(state.errorMessage ?? 'حدث خطا غير متوقع'));
        }

        if (state is QuestionsSuccessState || state is QuestionUpdatedState) {
          final questions = viewModel.questions;
          final totalQuestions = questions.length;
          final currentQuestion =
          questions[viewModel.currentQuestionIndex];
          final isDisabled = (currentQuestion.type == "MCQ" &&
              viewModel.selectedAnswerIndex == null) ||
              (currentQuestion.type == "ShortAnswer" &&
                  viewModel.shortAnswerController.text.trim().isEmpty);


          return SafeArea(
            child: Scaffold(
              backgroundColor: MyColors.backgroundColor,
              body: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // اسم الامتحان
                    Center(
                      child: Text(
                        "امتحان",
                        style: TextStyle(
                          fontFamily: 'Noto Kufi Arabic',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: MyColors.softBlackColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // تايمر
                    // تايمر
                    Center(
                      child: Container(
                        width: 75.w,
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        decoration: BoxDecoration(
                          color: MyColors.whiteColor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BlocBuilder<ExamDetailsViewModel, States>(
                              builder: (context, state) {
                                if (state is TimerTickState) {
                                  final minutes = state.remaining.inMinutes;
                                  final seconds = state.remaining.inSeconds % 60;
                                  return Text(
                                    "$minutes:${seconds.toString().padLeft(2, '0')}",
                                    style: TextStyle(
                                      fontFamily: 'Noto Kufi Arabic',
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500,
                                      color: MyColors.softBlackColor,
                                    ),
                                  );
                                } else if (state is TimerFinishedState) {
                                  return const Text(
                                    "انتهى ⏰",
                                    style: TextStyle(color: Colors.red),
                                  );
                                }
                                return const Text("--:--"); // في البداية لسه محملش
                              },
                            ),
                            SizedBox(width: 5.w),
                            SvgPicture.asset(
                              'assets/images/history.svg',
                              height: 20.h,
                              width: 20.w,
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 30.h),

                    // شريط تقدم
                    Text(
                      "الاسئلة ${viewModel.currentQuestionIndex + 1} من $totalQuestions سؤال",
                      style: TextStyle(
                        fontFamily: 'Noto Kufi Arabic',
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: MyColors.softBlackColor,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    LinearProgressIndicator(
                      value: (viewModel.currentQuestionIndex + 1) /
                          totalQuestions,
                      color: MyColors.primaryColor,
                      backgroundColor: MyColors.softGreyColor,
                      borderRadius: BorderRadius.circular(10.r),
                      minHeight: 10.h,
                    ),
                    SizedBox(height: 20.h),

                    // السؤال
                    Text(
                      currentQuestion.text ?? "",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        height: 2,
                        fontFamily: 'Noto Kufi Arabic',
                        color: MyColors.softBlackColor,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Dynamic Answers
                    Expanded(
                      child: currentQuestion.type == "MCQ"
                          ? ListView.builder(
                        itemCount:
                        currentQuestion.choices?.length ?? 0,
                        itemBuilder: (context, index) {
                          final choice =
                          currentQuestion.choices![index];
                          return Container(
                            margin:
                            EdgeInsets.symmetric(vertical: 8.h),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: viewModel.selectedAnswerIndex ==
                                    index
                                    ? MyColors.primaryColor
                                    : MyColors.greyColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child:CheckboxListTile(
                              value: viewModel.selectedAnswerIndex == index,
                              onChanged: (value) {
                                setState(() {
                                  if (value == true) {
                                    viewModel.selectedAnswerIndex = index;
                                  } else {
                                    viewModel.selectedAnswerIndex = null;
                                  }
                                });
                              },
                              title: Text(
                                choice.text ?? '',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Noto Kufi Arabic',
                                  color: MyColors.softBlackColor,
                                ),
                              ),
                              activeColor: MyColors.primaryColor,
                              controlAffinity: ListTileControlAffinity.leading,
                              checkColor: MyColors.whiteColor,
                              //fillColor: MaterialStateProperty.all(Colors.transparent),
                              side: BorderSide(
                                color:  MyColors.greyColor,
                                width: 1,
                              ),


                            ),
                          );
                        },
                      )
                          : TextField(
                        controller: viewModel.shortAnswerController,
                        onChanged: (value) {
                          context.read<ExamsScreenViewModel>().setShortAnswer(value);
                        },
                        decoration: InputDecoration(
                          hintText: "اكتب اجابتك هنا...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // أزرار التنقل
                    Row(
                      children: [
                    // زرار التالي / إنهاء
                    Expanded(
                    child: ElevatedButton(
                    onPressed: isDisabled
                        ? null
                        : () {
                      viewModel.goToNextQuestion();
                    },

                      style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.primaryColor, // دايمًا نفس اللون
                disabledBackgroundColor: MyColors.softPrimaryColor, // 🚨 لون زرار مقفول
                foregroundColor: MyColors.whiteColor,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                viewModel.currentQuestionIndex == totalQuestions - 1
                    ? "إنهاء الامتحان"
                    : "التالي",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Noto Kufi Arabic',
                  color: MyColors.whiteColor,
                ),
              ),
            ),
          ),



                        if (viewModel.currentQuestionIndex > 0)
                          SizedBox(width: 10.w),

                        // زرار السابق
                        if (viewModel.currentQuestionIndex > 0)
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                viewModel.goToPreviousQuestion();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MyColors.yellowColor,
                                foregroundColor: MyColors.whiteColor,
                                padding:
                                EdgeInsets.symmetric(vertical: 14.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: Text(
                                "السابق",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Noto Kufi Arabic',
                                  color: MyColors.whiteColor,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
