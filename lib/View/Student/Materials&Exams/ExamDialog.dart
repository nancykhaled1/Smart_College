import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../Cubits/States/States.dart';
import '../../../Cubits/Students/ExamDetailsViewModel.dart';
import '../../../Cubits/Students/ExamsScreenViewModel.dart';
import '../../../utils/colors.dart';
import 'QuestionsScreen.dart';

class ExamDialog extends StatefulWidget {
  final String examId;
  final int noOfQuestions;

  const ExamDialog({
    Key? key,
    required this.examId,
    required this.noOfQuestions
  }) : super(key: key);

  @override
  State<ExamDialog> createState() => _ExamDialogState();
}

class _ExamDialogState extends State<ExamDialog> {
  String? _examTitle; // هنا نخزن العنوان لما يبقى متاح

  @override
  void initState() {
    super.initState();
    context.read<ExamDetailsViewModel>().getExamDetails(widget.examId);
   // context.read<ExamsScreenViewModel>().getQuestions(widget.examId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExamDetailsViewModel, States>(
      listener: (context, state) {
        if (state is StartAttemptSuccessState) {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  ExamQuestionScreen(
                    examId: state.attempt.exam ?? "",
                    attemptId: state.attempt.id ?? "",
                    examTitle: _examTitle ?? 'امتحان', // لو مش متاح خلى افتراضى
                  ),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is LoadingState) {
          return AlertDialog(
            backgroundColor: MyColors.whiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
            content: SizedBox(
              width: 220.w,
              height: 180.h,
              child: Center(
                child: CircularProgressIndicator(
                  color: MyColors.primaryColor,
                ),
              ),
            ),
          );
        }
        else if (state is ExamDetailsSuccessState) {
          final details = state.examDetails;
          _examTitle = details.title;
          final parsedDate = DateTime.parse(details.createdAt!).toLocal();
          final formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);
          final examCubit = context.read<ExamsScreenViewModel>();
         /// examCubit.getQuestions(widget.examId);
          print(examCubit.questions.length);

          return BlocBuilder<ExamsScreenViewModel, States>(
            builder : (context, examState){
              return AlertDialog(
                backgroundColor: MyColors.whiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                contentPadding:
                EdgeInsets.symmetric(vertical: 40.h, horizontal: 25.w),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: MyColors.primaryColor,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: SvgPicture.asset('assets/images/quiz.svg'),
                            ),
                            SizedBox(height: 15.h),
                            SizedBox(
                              width: 80.w,
                              child: Text(
                                details.title ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Noto Kufi Arabic',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: MyColors.softBlackColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20.w),
                        Container(
                          height: 100.h,
                          child: VerticalDivider(
                            color: MyColors.greyColor,
                            thickness: 1,
                            width: 20,
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.alarm, color: MyColors.primaryColor),
                                SizedBox(width: 4.w),
                                Text(
                                  "${details.durationMinutes ?? 0} دقيقة",
                                  style: TextStyle(
                                    fontFamily: 'Noto Kufi Arabic',
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: MyColors.greyColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              children: [
                                Icon(Icons.calendar_month,
                                    color: MyColors.primaryColor),
                                SizedBox(width: 4.w),
                                Text(
                                  formattedDate,
                                  style: TextStyle(
                                    fontFamily: 'Noto Kufi Arabic',
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: MyColors.greyColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              children: [
                                Icon(Icons.text_snippet_outlined,
                                    color: MyColors.primaryColor),
                                SizedBox(width: 4.w),
                                Text(
                                  "${widget.noOfQuestions} سؤال",
                                  style: TextStyle(
                                    fontFamily: 'Noto Kufi Arabic',
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: MyColors.greyColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            context
                                .read<ExamDetailsViewModel>()
                                .startAttempt(widget.examId);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.primaryColor,
                            foregroundColor: MyColors.whiteColor,
                            padding: EdgeInsets.symmetric(
                              vertical: 6.h,
                              horizontal: 25.w,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Text(
                            "ابدأ الآن",
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontFamily: "Noto Kufi Arabic",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: 37.w),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.whiteColor,
                            foregroundColor: MyColors.primaryColor,
                            padding: EdgeInsets.symmetric(
                              vertical: 6.h,
                              horizontal: 35.w,
                            ),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: MyColors.primaryColor,
                                width: 1.w,
                              ),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Text(
                            "رجوع",
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontFamily: "Noto Kufi Arabic",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },

          );
        } else if (state is ErrorState) {
          return AlertDialog(
            backgroundColor: MyColors.whiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
            content: SizedBox(
              width: 220.w,
              height: 180.h,
              child: Column(
                children: [
                  Center(
                    child: Text(
                      state.errorMessage ?? "حدث خطأ",
                      style: TextStyle(
                        fontFamily: 'Noto Kufi Arabic',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: MyColors.softBlackColor,


                      ),
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.primaryColor,
                      foregroundColor: MyColors.whiteColor,
                      padding: EdgeInsets.symmetric(
                        vertical: 6.h,
                        horizontal: 40.w,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      "رجوع",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontFamily: "Noto Kufi Arabic",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
