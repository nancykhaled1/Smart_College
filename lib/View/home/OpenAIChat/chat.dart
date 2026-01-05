import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_college/Cubits/OpenAI/OpenAIChatCubit.dart';
import 'package:smart_college/Cubits/OpenAI/OpenAIChatStates.dart';
import 'package:smart_college/View/home/homeScreen.dart';
import 'package:smart_college/utils/colors.dart';


class ChatScreen extends StatefulWidget {
  

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();



  @override
  void initState() {
    super.initState();
    // OpenAI Chat doesn't need socket connection
  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.backgroundColor,
        body: BlocListener<OpenAIChatCubit, OpenAIChatStates>(
          listener: (context, state) {
            if (state is OpenAIChatErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.errorMessage,
                    style: TextStyle(fontFamily: "Noto Kufi Arabic"),
                  ),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 3),
                ),
              );
            }
          },
          child: Padding(
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
                "AI college chat",
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
                child: BlocBuilder<OpenAIChatCubit, OpenAIChatStates>(
                  builder: (context, state) {
                    if (state is OpenAIChatMessagesState) {
                      final messages = state.messages;
                      
                      if (messages.isEmpty && !state.isLoading) {
                        return Center(child: Text("ابدأ الدردشة"));
                      }

                      // Auto-scroll to bottom when new message arrives
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (_scrollController.hasClients) {
                          _scrollController.jumpTo(
                            _scrollController.position.maxScrollExtent,
                          );
                        }
                      });

                      return Stack(
                        children: [
                          ListView.builder(
                            controller: _scrollController,
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final message = messages[index];
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.h),
                                child: ChatBubble(
                                  text: message.content,
                                  isMe: message.isUser,
                                  time: DateFormat("hh:mm a").format(message.timestamp),
                                  senderName: message.isUser ? "أنت" : "AI Assistant",
                                ),
                              );
                            },
                          ),
                          if (state.isLoading)
                            Positioned(
                              bottom: 10,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: MyColors.primaryColor,
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                        ],
                      );
                    }

                    return Center(child: Text("ابدأ الدردشة"));
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
                      onSubmitted: (_) => _sendMessage(),
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
                      onPressed: () => _sendMessage(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }

  void _sendMessage() {
    final text = messageController.text.trim();
    if (text.isNotEmpty) {
      // Send message via OpenAI Chat API
      context.read<OpenAIChatCubit>().sendMessage(text);
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