import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final String time;
  final bool isSelected;

  const ChatBubble(
      {super.key, required this.text, required this.isMe, required this.time, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          // اسم المرسل (انت / admin)
          Align(
            alignment: isMe ? Alignment.topRight : Alignment.topLeft,
            child: Text(
              isMe ? 'انت' : 'admin',
              style: TextStyle(
                fontSize: 12.sp,
                color: MyColors.greyColor,
                fontWeight: FontWeight.w400,
                fontFamily: "Noto Kufi Arabic",
              ),
            ),
          ),

          // الفقاعة نفسها
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.h),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7, // أقصى عرض 70% من الشاشة
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.red.withOpacity(0.3) // 🟢 لون مميز للتحديد
                  : (isMe ? MyColors.softPrimaryColor : MyColors.darkGreenColor),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      text,
                      style: TextStyle(
                        color: isMe ? MyColors.softBlackColor : Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Noto Kufi Arabic",
                        height: 1.5.h,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    time, // الوقت فقط
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