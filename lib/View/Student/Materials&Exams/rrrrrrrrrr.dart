// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:smart_college/utils/colors.dart';
//
// class ExamQuestionScreen extends StatefulWidget {
//   @override
//   _ExamQuestionScreenState createState() => _ExamQuestionScreenState();
// }
//
// class _ExamQuestionScreenState extends State<ExamQuestionScreen> {
//   int currentQuestionIndex = 0;
//   int? selectedAnswerIndex; // اختيار واحد فقط
//
//   List<Map<String, dynamic>> questions = [
//     {
//       "question": "أي من العناصر التالية يُعتبر من مميزات الموقع الإلكتروني الجديد للكلية؟",
//       "answers": [
//         "صعوبة الوصول للمعلومات.",
//         "وجود تحديثات مستمرة وإشعارات فورية.",
//         "تصميم معقد وصعب الاستخدام.",
//         "تأخير في تحميل الصفحات.",
//       ]
//     },
//     {
//       "question": "ما هو اللون الأساسي في شعار الكلية؟",
//       "answers": [
//         "الأزرق",
//         "الأخضر",
//         "الأحمر",
//         "الأصفر",
//       ]
//     },
//     {
//       "question": "أي من العناصر التالية يُعتبر من مميزات الموقع الإلكتروني الجديد للكلية؟",
//       "answers": [
//         "صعوبة الوصول للمعلومات.",
//         "وجود تحديثات مستمرة وإشعارات فورية.",
//         "تصميم معقد وصعب الاستخدام.",
//         "تأخير في تحميل الصفحات.",
//       ]
//     },
//     {
//       "question": "أي من العناصر التالية يُعتبر من مميزات الموقع الإلكتروني الجديد للكلية؟",
//       "answers": [
//         "صعوبة الوصول للمعلومات.",
//         "وجود تحديثات مستمرة وإشعارات فورية.",
//         "تصميم معقد وصعب الاستخدام.",
//         "تأخير في تحميل الصفحات.",
//       ]
//     },
//   ];
//
//   void goToNextQuestion() {
//     if (currentQuestionIndex < questions.length - 1) {
//       setState(() {
//         currentQuestionIndex++;
//         selectedAnswerIndex = null; // reset الاختيار
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("انتهى الامتحان 👏")),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final totalQuestions = questions.length;
//     final currentQuestion = questions[currentQuestionIndex];
//
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: MyColors.backgroundColor,
//         body: Padding(
//           padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: Text(
//                   "اسم الامتحان",
//                   style: TextStyle(
//                     fontFamily: 'Noto Kufi Arabic',
//                     fontSize: 18.sp,
//                     fontWeight: FontWeight.w500,
//                     color: MyColors.softBlackColor,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20.h),
//
//               Center(
//                 child: Container(
//                   width: 75.w,
//                   padding: EdgeInsets.symmetric(vertical: 5.h),
//                   decoration: BoxDecoration(
//                     color: MyColors.whiteColor,
//                     borderRadius: BorderRadius.circular(10.r),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "28:22",
//                         style: TextStyle(
//                           fontFamily: 'Noto Kufi Arabic',
//                           fontSize: 13.sp,
//                           fontWeight: FontWeight.w500,
//                           color: MyColors.softBlackColor,
//                         ),
//                       ),
//                       SizedBox(width: 5.w),
//                       SvgPicture.asset(
//                         'assets/images/history.svg',
//                         height: 20.h,
//                         width: 20.w,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 30.h),
//
//               Text(
//                 "الاسئلة ${currentQuestionIndex + 1} من $totalQuestions سؤال",
//                 style: TextStyle(
//                   fontFamily: 'Noto Kufi Arabic',
//                   fontSize: 10.sp,
//                   fontWeight: FontWeight.w500,
//                   color: MyColors.softBlackColor,
//                 ),
//               ),
//               SizedBox(height: 10.h),
//
//               LinearProgressIndicator(
//                 value: (currentQuestionIndex + 1) / totalQuestions,
//                 color: MyColors.primaryColor,
//                 backgroundColor: MyColors.softGreyColor,
//                 borderRadius: BorderRadius.circular(10.r),
//                 minHeight: 10.h,
//               ),
//               SizedBox(height: 20.h),
//
//               Text(
//                 currentQuestion["question"],
//                 style: TextStyle(
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.w500,
//                   height: 2,
//                   fontFamily: 'Noto Kufi Arabic',
//                   color: MyColors.softBlackColor,
//                 ),
//               ),
//               SizedBox(height: 20.h),
//
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: currentQuestion["answers"].length,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       margin: EdgeInsets.symmetric(vertical: 8.h),
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: selectedAnswerIndex == index
//                               ? MyColors.primaryColor
//                               : MyColors.greyColor,
//                           width: 1,
//                         ),
//                         borderRadius: BorderRadius.circular(10.r),
//                       ),
//                       child: CheckboxListTile(
//                         value: selectedAnswerIndex == index,
//                         onChanged: (value) {
//                           setState(() {
//                             if (value == true) {
//                               selectedAnswerIndex = index;
//                             } else {
//                               selectedAnswerIndex = null;
//                             }
//                           });
//                         },
//                         title: Text(
//                           currentQuestion["answers"][index],
//                           style: TextStyle(
//                             fontSize: 13.sp,
//                             fontWeight: FontWeight.w500,
//                             fontFamily: 'Noto Kufi Arabic',
//                             color: MyColors.softBlackColor,
//                           ),
//                         ),
//                         activeColor: MyColors.primaryColor,
//                         controlAffinity: ListTileControlAffinity.leading,
//                         checkColor: MyColors.whiteColor,
//                         //fillColor: MaterialStateProperty.all(Colors.transparent),
//                         side: BorderSide(
//                           color:  MyColors.greyColor,
//                           width: 1,
//                         ),
//
//
//                       ),
//                     );
//                   },
//                 ),
//               ),
//
//               SizedBox(height: 20.h),
//
//               // زرارين السابق / التالي
//               Row(
//                 children: [
//                   // زرار التالي (شمال) أو إنهاء الامتحان
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         if (selectedAnswerIndex != null) {
//                           if (currentQuestionIndex < questions.length - 1) {
//                             goToNextQuestion();
//                           } else {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text("انتهى الامتحان 👏")),
//                             );
//                           }
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: selectedAnswerIndex == null
//                             ? MyColors.softPrimaryColor
//                             : MyColors.primaryColor,
//                         foregroundColor: MyColors.whiteColor,
//                         padding: EdgeInsets.symmetric(vertical: 14.h),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12.r),
//                         ),
//                       ),
//                       child: Text(
//                         currentQuestionIndex == questions.length - 1
//                             ? "إنهاء الامتحان"
//                             : "التالي",
//                         style: TextStyle(
//                           fontSize: 15.sp,
//                           fontWeight: FontWeight.w600,
//                           fontFamily: 'Noto Kufi Arabic',
//                           color: MyColors.whiteColor,
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   if (currentQuestionIndex > 0) SizedBox(width: 10.w), // مسافة بينهم
//
//                   // زرار السابق (يمين)
//                   if (currentQuestionIndex > 0)
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           setState(() {
//                             currentQuestionIndex--;
//                           //  selectedAnswerIndex = null; // reset عند الرجوع
//                           });
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: MyColors.yellowColor,
//                           foregroundColor: MyColors.whiteColor,
//                           padding: EdgeInsets.symmetric(vertical: 14.h),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12.r),
//                           ),
//                         ),
//                         child: Text(
//                           "السابق",
//                           style: TextStyle(
//                             fontSize: 15.sp,
//                             fontWeight: FontWeight.w600,
//                             fontFamily: 'Noto Kufi Arabic',
//                             color: MyColors.whiteColor,
//                           ),
//                         ),
//                       ),
//                     ),
//                 ],
//               )
//
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }