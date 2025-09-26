import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:smart_college/Cubits/Students/ExamsScreenViewModel.dart';
import 'package:smart_college/View/Student/Materials&Exams/ExamScreen.dart';

import '../../../Cubits/States/States.dart';
import '../../../Cubits/Students/ExamDetailsViewModel.dart';
import '../../../utils/colors.dart';
import 'QuestionsScreen.dart';

class ExamDialog extends StatefulWidget {
  final String examId;


  const ExamDialog({
    Key? key,
    required this.examId
  }) : super(key: key);

  @override
  State<ExamDialog> createState() => _ExamDialogState();
}

class _ExamDialogState extends State<ExamDialog> {
  @override
  void initState() {
    super.initState();
    context.read<ExamDetailsViewModel>().getExamDetails(widget.examId);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: MyColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      contentPadding: EdgeInsets.symmetric(
        vertical: 40.h,
        horizontal: 25.w
      ),
      content: BlocBuilder<ExamDetailsViewModel, States>(
        builder: (context, state) {
          if (state is LoadingState) {
            return SizedBox(
              width: 220.w,
              height: 180.h,
              child: Center(
                child: CircularProgressIndicator(
                  color: MyColors.primaryColor,
                ),
              ),
            );
          } else if (state is ExamDetailsSuccessState) {
            final details = state.examDetails;
            final parsedDate = DateTime.parse(details.createdAt!).toLocal();
            final formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);

            return Column(
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
                            child: SvgPicture.asset('assets/images/quiz.svg')
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        SizedBox(
                          width: 80.w, // تحدد عرض مناسب أو سيبه مرن
                          child: Text(
                            details.title ?? '',
                            maxLines: 2, // يخلي العنوان ينزل سطرين لو طويل
                            overflow: TextOverflow.ellipsis, // يحط "..." لو كبر أكتر
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
                    SizedBox(
                      width: 20.w,
                    ),
                    Container(
                      height: 100.h,
                      child: VerticalDivider(
                        color: MyColors.greyColor,
                        thickness: 1,
                        width: 20, // المسافة حوالين الخط
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.alarm,
                              color: MyColors.primaryColor,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text("${details.durationMinutes ?? 0} دقيقة" ,
                              style: TextStyle(
                                fontFamily: 'Noto Kufi Arabic',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: MyColors.greyColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Icon(Icons.calendar_month,
                              color: MyColors.primaryColor,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text(formattedDate,
                              style: TextStyle(
                                fontFamily: 'Noto Kufi Arabic',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: MyColors.greyColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Icon(Icons.text_snippet_outlined,
                              color: MyColors.primaryColor,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text("${details.questions?.length ?? 0} سؤال",
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
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => ExamQuestionScreen(),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
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
                      // child: state is LoadingState
                      //     ? SizedBox(
                      //   width: 20.w,
                      //   height: 20.w,
                      //   child: CircularProgressIndicator(
                      //     strokeWidth: 2,
                      //     valueColor: AlwaysStoppedAnimation<Color>(MyColors.whiteColor),
                      //   ),
                      // )
                      //     :
                      child:Text(
                        "ابدا الان",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: "Noto Kufi Arabic",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 37.w,
                    ),
                    ElevatedButton(
                      onPressed: (){
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
                            color: MyColors.primaryColor, // لون البوردر
                            width: 1.w, // سمك البوردر
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      // child: state is LoadingState
                      //     ? SizedBox(
                      //   width: 20.w,
                      //   height: 20.w,
                      //   child: CircularProgressIndicator(
                      //     strokeWidth: 2,
                      //     valueColor: AlwaysStoppedAnimation<Color>(MyColors.whiteColor),
                      //   ),
                      // )
                      //     :
                      child:Text(
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

            );
          } else if (state is ErrorState) {
            return SizedBox(
              width: 220.w,
              height: 180.h,
              child: Column(
                children: [
                  Center(
                    child: Text("${state.errorMessage}",
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
                    onPressed: (){
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
                    child:Text(
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
            );
          } else {
            return const SizedBox();
          }
        },
      ),





    );
  }
}
