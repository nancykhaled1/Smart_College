import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_college/View/home/homeScreen.dart';
import 'package:smart_college/utils/colors.dart';
import '../../../Cubits/States/States.dart';
import '../../../Cubits/Students/ExamsScreenViewModel.dart';
import '../../../Models/Response/MyAttemptsResponse.dart';

class ResultQuestionScreen extends StatefulWidget {
  final MyAttempts attempt; // ← نمرر محاولة كاملة
  const ResultQuestionScreen({super.key, required this.attempt});

  @override
  State<ResultQuestionScreen> createState() => _ResultQuestionScreenState();
}

class _ResultQuestionScreenState extends State<ResultQuestionScreen> {
  @override
  void initState() {
    super.initState();
    final examId = widget.attempt.exam?.id;
    // التأكد من أن examId ليس null قبل تمريره
    if (examId != null) {
      context.read<ExamsScreenViewModel>().getQuestions(examId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final attempt = widget.attempt;
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.backgroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
          child: BlocBuilder<ExamsScreenViewModel, States>(
            builder: (context, state) {
              final viewModel = context.read<ExamsScreenViewModel>();

              if (state is LoadingState) {
                return const Center(
                  child: CircularProgressIndicator(color: MyColors.primaryColor),
                );
              }

              if (state is ErrorState) {
                return Center(
                  child: Text(
                    state.errorMessage ?? 'حدث خطأ أثناء تحميل الأسئلة',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              final questions = viewModel.questions;
              if (questions.isEmpty) {
                return const Center(child: Text("لا توجد أسئلة 😅"));
              }

              final totalQuestions = questions.length;
              final currentQuestion = questions[viewModel.currentQuestionIndex];

              // 🟢 نجيب إجابة الطالب للسؤال الحالي
              final answers = attempt.answers ?? [];

              final userAnswerData = answers.firstWhere(
                    (ans) => ans.question == currentQuestion.id,
                orElse: () => Answer(), // بيرجع كائن فاضي بدل null
              );

              final String? userAnswer = userAnswerData.answer;
              final int? points = userAnswerData.pointsAwarded;


              // الإجابة الصح من السيرفر
              final String? correctAnswer = currentQuestion.correctAnswer;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      attempt.exam!.title ??'',
                      style: TextStyle(
                        fontFamily: 'Noto Kufi Arabic',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: MyColors.softBlackColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),

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

                  Expanded(
                    child: currentQuestion.type == "MCQ"
                        ? ListView.builder(
                      itemCount: currentQuestion.choices?.length ?? 0,
                      itemBuilder: (context, index) {
                        final choice = currentQuestion.choices![index];

                        final isUserAnswer = userAnswer == choice.text;
                        final isCorrectAnswer = correctAnswer == choice.text;
                        print('answer$correctAnswer');

                        Color borderColor = MyColors.greyColor;
                        IconData? icon;
                        Color? iconColor;

                        if (isCorrectAnswer) {
                          borderColor = MyColors.primaryColor;
                          icon = Icons.check;
                          iconColor = MyColors.primaryColor;
                        }

                        // 2. لو الخيار هو إجابة الطالب (يعدل التنسيق إذا كانت خاطئة)
                        if (isUserAnswer) {
                          if (points != null && points > 0) {
                            // إجابة الطالب صحيحة (تأكيد اللون الأخضر)
                            borderColor = MyColors.primaryColor;
                            icon = Icons.check;
                            iconColor = MyColors.primaryColor;
                          } else {
                            // إجابة الطالب خاطئة (يظهرها باللون الأحمر)
                            borderColor = MyColors.redColor;
                            icon = Icons.close;
                            iconColor = MyColors.redColor;
                          }
                        }

                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 8.h),
                          decoration: BoxDecoration(
                            color: MyColors.backgroundColor,
                            border: Border.all(color: borderColor, width: 1.w),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                // 🔲 المربع اللي فيه العلامة
                                Container(
                                  height: 18.h,
                                  width: 18.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: borderColor, width: 1.w),
                                    borderRadius: BorderRadius.circular(4.r),
                                    color: Colors.transparent,
                                  ),
                                  child: (isUserAnswer || isCorrectAnswer)
                                      ? Center(
                                    child: Icon(
                                      icon,
                                      color: iconColor,
                                      size: 15.sp,
                                    ),
                                  )
                                      : null,
                                ),
                                SizedBox(width: 20.w),
                                // 📝 نص الإجابة
                                Expanded(
                                  child: Text(
                                    choice.text ?? '',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Noto Kufi Arabic',
                                      color: MyColors.softBlackColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },

                    )

                        : TextField(
                      enabled: false,
                      controller:
                      TextEditingController(text: userAnswer ?? ''),
                      decoration: InputDecoration(
                        labelText: "إجابتك:",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed:
                          viewModel.currentQuestionIndex < totalQuestions - 1
                              ? () {
                            viewModel.goToNextQuestion();
                          }
                              : () {
                            Navigator.pushReplacementNamed(
                                context, HomeScreen.routeName);
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
                          child: Text(
                            viewModel.currentQuestionIndex < totalQuestions - 1
                                ? "التالي"
                                : "إنهاء",
                            style: TextStyle(
                              fontFamily: 'Noto Kufi Arabic',
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                              color: MyColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                      if (viewModel.currentQuestionIndex > 0)
                        SizedBox(width: 10.w),
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
                            child: Text(
                              "السابق",
                              style: TextStyle(
                                fontFamily: 'Noto Kufi Arabic',
                                fontWeight: FontWeight.w600,
                                fontSize: 15.sp,
                                color: MyColors.whiteColor,
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
    );
  }
}