// import 'dart:async';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
// import '../../Cubits/Home/ChatScreenViewModel.dart';
// import '../../Cubits/States/States.dart';
// import '../../services/local/sharedPreference.dart';
// import '../../utils/colors.dart';
// import '../Graduated/home/graduatedHomeScreen.dart';
//
// class ChatScreen extends StatefulWidget {
//   static const String routeName = 'smartChat';
//
//   const ChatScreen({super.key});
//
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   TextEditingController messageController = TextEditingController();
//
//   Timer? _timer;
//
//   // Message? selectedMessage; // 🟢 الرسالة اللي متحددة
//
//
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: MyColors.backgroundColor,
//         body: Padding(
//           padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
//           child: Column(
//             children: [
//               /// الهيدر
//               Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       if (selectedMessage != null) {
//                         // 🟢 لو فيه رسالة متعلم عليها → الغي التحديد
//                         setState(() {
//                           selectedMessage = null;
//                         });
//                       } else {
//                         Navigator.of(context).pushReplacement(
//                           PageRouteBuilder(
//                             pageBuilder: (context, animation, secondaryAnimation) =>
//                                 GraduatedHomeScreen(),
//                             transitionDuration: Duration.zero,
//                             reverseTransitionDuration: Duration.zero,
//                           ),
//                         );
//                       }
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: MyColors.whiteColor,
//                         borderRadius: BorderRadius.circular(10.r),
//                       ),
//                       child: Icon(
//                         selectedMessage != null ? Icons.close : Icons.arrow_back_ios_new,
//                         color: MyColors.primaryColor,
//                         size: 20,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 20.w),
//                   Expanded(
//                     child: Text(
//                       selectedMessage != null
//                           ? (selectedMessage!.from == context.read<SendMessageCubit>().currentUserId
//                           ? "انت"
//                           : "admin")
//                           : "smart college chat",
//                       style: TextStyle(
//                         fontFamily: 'Noto Kufi Arabic',
//                         fontSize: 20.sp,
//                         fontWeight: FontWeight.w500,
//                         color: MyColors.softBlackColor,
//                       ),
//                     ),
//                   ),
//                   if (selectedMessage != null)
//                     IconButton(
//                       icon: Icon(Icons.delete, color: Colors.red),
//                       onPressed: () {
//                         // context.read<SendMessageCubit>().deleteMessage(selectedMessage!.id);
//                         // setState(() {
//                         //   selectedMessage = null;
//                         // });
//                       },
//                     ),
//                 ],
//               ),
//
//               SizedBox(height: 10.h),
//
//               /// الرسائل
//               Expanded(
//                 child: BlocBuilder<SendMessageCubit, States>(
//                   builder: (context, state) {
//                     final cubit = context.read<SendMessageCubit>();
//
//                     if (state is LoadingState && cubit.allMessages.isEmpty) {
//                       return const Center(
//                         child: CircularProgressIndicator(
//                           color: MyColors.primaryColor,
//                         ),
//                       );
//                     }
//
//                     if (cubit.allMessages.isEmpty) {
//                       return const Center(child: Text("ابدأ الدردشة"));
//                     }
//
//                     return ListView.builder(
//                       controller:cubit.scrollController,
//                       itemCount: cubit.allMessages.length,
//                       itemBuilder: (context, index) {
//                         final msg = cubit.allMessages[index];
//
//                         // 🟢 نحاول نقرأ التاريخ
//                         DateTime? dateTime = DateTime.tryParse(msg.createdAt ?? "");
//
//                         // // لو التاريخ null أو فاضي → نخلي الوقت الحالي
//                         dateTime ??= DateTime.now();
//                         //
//                         // // حوله للوقت المحلي
//                         dateTime = dateTime.toLocal();
//
//                         // صيغة التاريخ لليوم
//                         final formattedDate = DateFormat("yyyy-MM-dd").format(dateTime);
//
//                         // هل نعرض التاريخ فوق الرسالة دي ولا لأ
//                         bool showDateHeader = true;
//                         if (index > 0) {
//                           final prevMsg = cubit.allMessages[index - 1];
//
//                           DateTime? prevDateTime = DateTime.tryParse(prevMsg.createdAt ?? "");
//                           prevDateTime ??= DateTime.now();
//                           prevDateTime = prevDateTime.toLocal();
//
//                           final prevDate = DateFormat("yyyy-MM-dd").format(prevDateTime);
//
//                           if (prevDate == formattedDate) {
//                             showDateHeader = false;
//                           }
//                         }
//
//                         return Column(
//                           children: [
//                             if (showDateHeader)
//                               Padding(
//                                 padding: EdgeInsets.symmetric(vertical: 8.h),
//                                 child: Text(
//                                   formattedDate,
//                                   style: TextStyle(
//                                     fontSize: 12.sp,
//                                     color: MyColors.greyColor,
//                                     fontWeight: FontWeight.bold,
//                                     fontFamily: "Noto Kufi Arabic",
//                                   ),
//                                 ),
//                               ),
//                         GestureDetector(
//                         onLongPress: () {
//                         setState(() {
//                         selectedMessage = msg; // 🟢 حدد الرسالة
//                         });
//                         },
//                         child: ChatBubble(
//                         text: msg.text ?? "",
//                         isMe: msg.from == cubit.currentUserId,
//                         time: DateFormat("hh:mm a").format(dateTime),
//                         isSelected: selectedMessage?.id == msg.id, // 🟢 نضيف تمييز
//                         ),
//                         ),
//
//                         ],
//                         );
//                       },
//                     );
//
//                   },
//                 ),
//               ),
//
//               /// إدخال رسالة
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: messageController,
//                       decoration: InputDecoration(
//                         hintText: "اكتب رسالتك...",
//                         hintStyle: TextStyle(
//                           color: MyColors.greyColor,
//                           fontSize: 14.sp,
//                           fontFamily: "Noto Kufi Arabic",
//                           fontWeight: FontWeight.w400,
//                         ),
//                         filled: true,
//                         fillColor: Colors.white,
//                         contentPadding: EdgeInsets.symmetric(
//                           horizontal: 20.w,
//                           vertical: 10.h,
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.r),
//                           borderSide: BorderSide(
//                               color: MyColors.greyColor, width: 1.5.w),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: MyColors.greyColor, width: 1.5.w),
//                           borderRadius: BorderRadius.circular(10.r),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   CircleAvatar(
//                     backgroundColor: MyColors.primaryColor,
//                     child: IconButton(
//                       icon: const Icon(Icons.send, color: Colors.white),
//                       onPressed: () {
//                         // final text = messageController.text.trim();
//                         // if (text.isNotEmpty) {
//                         //   context.read<SendMessageCubit>().sendMessage(
//                         //     adminId: "68b03a97fdc16819370d2bb2",
//                         //     text: text,
//                         //   );
//                         //   messageController.clear();
//                         // }
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
// class ChatBubble extends StatelessWidget {
//   final String text;
//   final bool isMe;
//   final String time;
//   final bool isSelected;
//
//   const ChatBubble(
//       {super.key, required this.text, required this.isMe, required this.time , this.isSelected = false,});
//
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//       child: Column(
//         crossAxisAlignment:
//         isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
//         children: [
//           // اسم المرسل (انت / admin)
//           Align(
//             alignment: isMe ? Alignment.topRight : Alignment.topLeft,
//             child: Text(
//               isMe ? 'انت' : 'admin',
//               style: TextStyle(
//                 fontSize: 12.sp,
//                 color: MyColors.greyColor,
//                 fontWeight: FontWeight.w400,
//                 fontFamily: "Noto Kufi Arabic",
//               ),
//             ),
//           ),
//
//           // الفقاعة نفسها
//           Container(
//             margin: EdgeInsets.symmetric(vertical: 8.h),
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             constraints: BoxConstraints(
//               maxWidth: MediaQuery.of(context).size.width * 0.7, // أقصى عرض 70% من الشاشة
//             ),
//             decoration: BoxDecoration(
//               color: isSelected
//                   ? Colors.red.withOpacity(0.3) // 🟢 لو متعلم عليها تبان بلون مختلف
//                   : (isMe ? MyColors.softPrimaryColor : MyColors.darkGreenColor),
//               borderRadius: BorderRadius.circular(20.r),
//             ),
//             child: IntrinsicWidth(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Flexible(
//                     child: Text(
//                       text,
//                       style: TextStyle(
//                         color: isMe ? MyColors.softBlackColor : Colors.white,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w400,
//                         fontFamily: "Noto Kufi Arabic",
//                         height: 1.5.h,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 6),
//                   Text(
//                     time, // الوقت فقط
//                     style: TextStyle(
//                       fontSize: 9.sp,
//                       color: MyColors.greyColor,
//                       fontWeight: FontWeight.w400,
//                       fontFamily: "Noto Kufi Arabic",
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }