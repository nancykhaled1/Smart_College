import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_college/View/home/homeScreen.dart';
import 'package:smart_college/utils/colors.dart';
import 'package:smart_college/utils/result.dart';

import '../../../Cubits/States/States.dart';
import '../../../Cubits/Students/ExamDetailsViewModel.dart';
import '../../../Cubits/Students/ExamsScreenViewModel.dart';

class ExamQuestionScreen extends StatefulWidget {
  final String examId;
  final String attemptId;
  final String examTitle;

  const ExamQuestionScreen({
    super.key,
    required this.examId,
    required this.attemptId,
    required this.examTitle,
  });

  @override
  _ExamQuestionScreenState createState() => _ExamQuestionScreenState();
}

class _ExamQuestionScreenState extends State<ExamQuestionScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ExamsScreenViewModel>().getQuestions(widget.examId);
    final viewModel = context.read<ExamsScreenViewModel>();
    viewModel.shortAnswerController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          final viewModel = context.read<ExamsScreenViewModel>();
          viewModel.submitAttempt(widget.attemptId);
          context.read<ExamDetailsViewModel>().stopTimer();
          return true; // يسمح بالرجوع
        },
        child: Scaffold(
          backgroundColor: MyColors.backgroundColor,
          body: BlocListener<ExamsScreenViewModel, States>(
            listener: (context, state) {
              if (state is SubmitAnswerSuccessState) {
                final examResultData = {
                  "examTitle": widget.examTitle,
                  "correct": state.attempt.attempt?.correctCount,
                  "wrong": state.attempt.attempt?.wrongCount,
                  "total": state.attempt.attempt?.totalPoints,
                  "maxPoints": state.attempt.maxPoints,
                };
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return BuildDialog(
                          image: "assets/images/success.svg",
                          message: "تم تسليم الامتحان بنجاح",
                        examData: examResultData,
                      );

                    },
                  );
                });
              }
              if (state is TimerFinishedState) {
                final viewModel = context.read<ExamsScreenViewModel>();
                viewModel.submitAttempt(widget.attemptId);
                context.read<ExamDetailsViewModel>().stopTimer();

              }
            },

            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
              child: BlocBuilder<ExamsScreenViewModel, States>(
                builder: (context, state) {
                  final viewModel = context.read<ExamsScreenViewModel>();


                  // if (state is LoadingState) {
                  //   return const Center(
                  //     child: CircularProgressIndicator(
                  //       color: MyColors.primaryColor,
                  //     ),
                  //   );
                  // }

                  if (state is ErrorState) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(state.errorMessage ?? 'حدث خطأ غير متوقع',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontFamily: "Noto Kufi Arabic",
                            fontWeight: FontWeight.w400,
                          ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          ElevatedButton(
                            onPressed: (){
                              Navigator.of(context).pushReplacement(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                ),
                              );

                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.primaryColor,
                              foregroundColor: MyColors.whiteColor,
                              padding: EdgeInsets.symmetric(
                                vertical: 10.h,
                                horizontal: 105.w,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            child: Text(
                              "الرجوع للرئيسية",
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontFamily: "Noto Kufi Arabic",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  final questions = viewModel.questions;
                  if (questions.isEmpty) {
                    return const Center(child: Text("لا توجد أسئلة حاليا"));
                  }

                  final totalQuestions = questions.length;
                  final currentQuestion =
                  questions[viewModel.currentQuestionIndex];

                  // 🟢 استرجاع الإجابة المحفوظة
                  final savedAnswer =
                  viewModel.answers[viewModel.currentQuestionIndex];

                  if (currentQuestion.type == "MCQ") {
                    if (savedAnswer != null) {
                      final savedIndex = currentQuestion.choices
                          ?.indexWhere((c) => c.text == savedAnswer);
                      if (savedIndex != -1) {
                        viewModel.selectedAnswerIndex = savedIndex;
                      }
                    }
                  } else if (currentQuestion.type == "short-answer") {
                    if (savedAnswer != null &&
                        savedAnswer != viewModel.shortAnswerController.text) {
                      viewModel.shortAnswerController.text = savedAnswer;
                    }
                  }

                  final isDisabled = (currentQuestion.type == "MCQ" &&
                      viewModel.selectedAnswerIndex == null) ||
                      (currentQuestion.type == "short-answer" &&
                          viewModel.shortAnswerController.text.trim().isEmpty);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // اسم الامتحان
                      Center(
                        child: Text(
                          widget.examTitle,
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
                                    final seconds =
                                        state.remaining.inSeconds % 60;
                                    return Text(
                                      "$minutes:${seconds.toString().padLeft(2, '0')}",
                                      style: TextStyle(
                                        fontFamily: 'Noto Kufi Arabic',
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                        color: MyColors.softBlackColor,
                                      ),
                                    );
                                  }
                                  else if (state is TimerFinishedState) {
                                    return const Text(
                                      "انتهى ⏰",
                                      style: TextStyle(color: Colors.red),
                                    );
                                  }
                                  return const Text("--:--");
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
                        value:
                        (viewModel.currentQuestionIndex + 1) / totalQuestions,
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
                          itemCount: currentQuestion.choices?.length ?? 0,
                          itemBuilder: (context, index) {
                            final choice =
                            currentQuestion.choices![index];
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 8.h),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                  viewModel.selectedAnswerIndex == index
                                      ? MyColors.primaryColor
                                      : MyColors.greyColor,
                                  width: 1.w,
                                ),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: CheckboxListTile(
                                value: viewModel.selectedAnswerIndex ==
                                    index,
                                onChanged: (value) {
                                  setState(() {
                                    if (value == true) {
                                      viewModel.selectedAnswerIndex = index;
                                      // ✅ تحديث الإجابة مباشرة
                                      viewModel.answers[viewModel.currentQuestionIndex] =
                                          currentQuestion.choices![index].text ?? "";
                                    } else {
                                      viewModel.selectedAnswerIndex = null;
                                      viewModel.answers.remove(viewModel.currentQuestionIndex); // لو لغى الاختيار
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
                                controlAffinity:
                                ListTileControlAffinity.leading,
                                checkColor: MyColors.whiteColor,
                                side: const BorderSide(
                                  color: MyColors.greyColor,
                                  width: 1,
                                ),
                              ),
                            );
                          },
                        )
                            : TextField(
                          controller: viewModel.shortAnswerController,
                          onChanged: (value) {
                            context
                                .read<ExamsScreenViewModel>()
                                .setShortAnswer(value);
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
                              onPressed: isDisabled || state is LoadingState
                                  ? null
                                  : () {
                                final currentQuestion =
                                viewModel.questions[viewModel.currentQuestionIndex];

                                dynamic answerToSave;
                                if (currentQuestion.type == "MCQ") {
                                  final selectedIndex = viewModel.selectedAnswerIndex;
                                  if (selectedIndex != null &&
                                      selectedIndex < (currentQuestion.choices?.length ?? 0)) {
                                    answerToSave =
                                        currentQuestion.choices![selectedIndex].text ?? "";
                                  }
                                } else if (currentQuestion.type == "short-answer") {
                                  answerToSave = viewModel.shortAnswerController.text.trim();
                                }

                                if (answerToSave != null && answerToSave.isNotEmpty) {
                                  viewModel.answers[viewModel.currentQuestionIndex] = answerToSave;

                                  viewModel.saveAnswer(
                                    widget.attemptId,
                                    currentQuestion.id ?? "",
                                    widget.examId,
                                    onSuccess: () {
                                      if (viewModel.currentQuestionIndex == totalQuestions - 1) {
                                        viewModel.submitAttempt(widget.attemptId);
                                        context.read<ExamDetailsViewModel>().stopTimer();
                                      } else {
                                        viewModel.goToNextQuestion();
                                      }
                                    },
                                  );
                                } else {
                                  if (viewModel.currentQuestionIndex == totalQuestions - 1) {
                                    viewModel.submitAttempt(widget.attemptId);
                                    context.read<ExamDetailsViewModel>().stopTimer();
                                  } else {
                                    viewModel.goToNextQuestion();
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MyColors.primaryColor,
                                disabledBackgroundColor: MyColors.softPrimaryColor,
                                foregroundColor: MyColors.whiteColor,
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: state is LoadingState
                                  ? SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(MyColors.whiteColor),
                                ),
                              )
                                  : Text(
                                viewModel.currentQuestionIndex == totalQuestions - 1
                                    ? "إنهاء الامتحان"
                                    : "التالي",
                                style: TextStyle(
                                  fontFamily: 'Noto Kufi Arabic',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.sp,
                                  color: MyColors.whiteColor
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
                                  padding: EdgeInsets.symmetric(vertical: 14.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                                child:  Text("السابق",
                                  style: TextStyle(
                                      fontFamily: 'Noto Kufi Arabic',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.sp,
                                      color: MyColors.whiteColor
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
