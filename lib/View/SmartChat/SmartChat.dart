import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_college/View/Student/Home/StudentHomeScreen.dart';
import 'package:smart_college/View/home/homeScreen.dart';
import '../../Cubits/Home/ChatScreenViewModel.dart';
import '../../Cubits/States/States.dart';
import '../../utils/colors.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = 'smartChat';

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;



  @override
  void initState() {
    super.initState();
    final cubit = context.read<ChatCubit>();
    cubit.connectSocket();
  }




  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChatCubit>();


    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.backgroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
          child: Column(
            children: [
              Row(
                children: [
                GestureDetector(
                  onTap: () {
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) =>
                              HomeScreen(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: MyColors.whiteColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                       Icons.arrow_back_ios_new,
                      color: MyColors.primaryColor,
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(width: 40.w),
                Text(
                "smart college chat",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Noto Kufi Arabic',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: MyColors.softBlackColor,
                  ),
                ),
              ],
            ),
              /// ✅ الرسائل
              Expanded(
                child: BlocBuilder<ChatCubit, ChatStates>(
                  builder: (context, state) {
                    final cubit = context.read<ChatCubit>();
                    final messages = cubit.messages;


                    if (state is ChatConnecting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: MyColors.primaryColor,
                        ),
                      );
                    }

                    if (state is ChatDisconnected) {
                      return const Center(
                        child: Text("غير متصل بالسيرفر"),
                      );
                    }

                    if (state is LoadingState) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: MyColors.primaryColor,
                        ),
                      );
                    }

                    if (state is ChatMessagesUpdated) {
                     // final messages = state.messages;

                      if (messages.isEmpty) {
                        return const Center(child: Text("ابدأ الدردشة"));
                      }

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (_scrollController.hasClients) {
                          _scrollController.jumpTo(
                            _scrollController.position.maxScrollExtent,
                          );
                        }
                      });

                      return ListView.builder(
                        itemCount: messages.length,
                        controller: _scrollController,
                        itemBuilder: (context, index) {
                          final msg = messages[index];
                          // 🟢 تحويل الوقت
                          DateTime dateTime = DateTime.tryParse(
                            msg.createdAt ?? "",
                          )?.toLocal() ??
                              DateTime.now();

                          final formattedDate =
                          DateFormat("yyyy-MM-dd").format(dateTime);

                          bool showDateHeader = true;
                          if (index > 0) {
                            final prevMsg = messages[index - 1];
                            final prevDateTime = DateTime.tryParse(
                              prevMsg.createdAt ?? "",
                            )?.toLocal() ??
                                DateTime.now();
                            final prevDate = DateFormat("yyyy-MM-dd")
                                .format(prevDateTime);
                            if (prevDate == formattedDate) {
                              showDateHeader = false;
                            }
                          }

                          return Column(
                            children: [
                              if (showDateHeader)
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.h),
                                  child: Text(
                                    formattedDate,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: MyColors.greyColor,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Noto Kufi Arabic",
                                    ),
                                  ),
                                ),
                              ChatBubble(
                                text: msg.content ?? "",
                                isMe: msg.senderModel == "User", // 👈 لو User تبقى انت، لو Admin يبقى مش انت
                                time: DateFormat("hh:mm a").format(dateTime),
                                senderName: msg.sender?.name ?? 'admin', // 👈 مرري اسم المرسل

                              ),
                            ],
                          );
                        },
                      );
                    }

                    return Container();
                  },
                ),
              ),

              /// ✅ إدخال رسالة
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: "اكتب رسالتك...",
                        hintStyle: TextStyle(
                          color: MyColors.greyColor,
                          fontSize: 14.sp,
                          fontFamily: "Noto Kufi Arabic",
                          fontWeight: FontWeight.w400,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            color: MyColors.greyColor,
                            width: 1.5.w,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: MyColors.primaryColor,
                            width: 1.5.w,
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(cubit),
                      // onChanged: (val) {
                      //   cubit.setTyping(val.isNotEmpty);
                      //   _timer?.cancel();
                      //   _timer = Timer(const Duration(seconds: 2), () {
                      //     cubit.setTyping(false);
                      //   });
                      // },
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: MyColors.primaryColor,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: () => _sendMessage(cubit),
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

  void _sendMessage(ChatCubit cubit) {
    final text = messageController.text.trim();
    if (text.isNotEmpty) {
      cubit.sendMessage(text);
      messageController.clear();
    }
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final String time;
  final String senderName; // 👈 جديد


  const ChatBubble({
    super.key,
    required this.text,
    required this.isMe,
    required this.time,
    required this.senderName
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerLeft : Alignment.centerRight,
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          // ✅ اسم المرسل
          Align(
            alignment: isMe ? Alignment.topRight : Alignment.topLeft,
            child: Text(
                  isMe ? 'انت' : senderName,

              style: TextStyle(
                fontSize: 12.sp,
                color: MyColors.greyColor,
                fontWeight: FontWeight.w400,
                fontFamily: "Noto Kufi Arabic",
              ),
            ),
          ),

          // ✅ فقاعة الرسالة
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.h),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            decoration: BoxDecoration(
              color: isMe ? MyColors.softPrimaryColor : MyColors.darkGreenColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      color: isMe ? MyColors.softBlackColor : Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Noto Kufi Arabic",
                      height: 1.5.h,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 9.sp,
                      color: MyColors.greyColor,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Noto Kufi Arabic",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
