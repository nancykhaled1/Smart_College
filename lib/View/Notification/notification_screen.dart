import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_college/Cubits/States/States.dart';
import 'package:smart_college/View/Graduated/home/graduatedHomeScreen.dart';
import '../../../../Cubits/Home/GetNotificationViewModel.dart';
import '../../../../utils/colors.dart';
import 'NotificationDetails.dart';
import 'notification_card.dart';

class NotificationScreen extends StatefulWidget {
  static const String routeName = 'notification';

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationScreenViewModel>().getNotification();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          // هنا بتتحكمى هل ترجعى ولا لا
          return false; // ❌ مش هيرجع
          // return true;  ✅ هيرجع
        },
        child: Scaffold(
          backgroundColor: MyColors.backgroundColor,
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // زرار رجوع
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => GraduatedHomeScreen(),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );

                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: MyColors.whiteColor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: MyColors.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 80.w,),
                    Text('الاشعارات',
                      style: TextStyle(
                        fontFamily: 'Noto Kufi Arabic',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: MyColors.softBlackColor,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                // BlocBuilder لمتابعة الـ state
                Expanded(
                  child: BlocBuilder<NotificationScreenViewModel, States>(
                    builder: (context, state) {

                      if (state is LoadingState) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: MyColors.primaryColor,
                          ),
                        );
                      } else if (state is ErrorState) {
                        final error = state.errorMessage;

                        if (error == "No Internet Connection") {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/no_internet.png", // 🖼️ ضيفي صورة عندك
                                width: 200,
                                height: 200,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "لا يوجد اتصال بالانترنت",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: MyColors.greyColor,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Noto Kufi Arabic",
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Center(
                            child: Text(
                               "حدث خطأ غير متوقع المحاوله فى وقت لاحق",
                              style: TextStyle(
                                color: MyColors.greyColor,
                                fontSize: 16.sp,
                              ),
                            ),
                          );
                        }

                      } else if (state is GetNotificationSuccessState) {
                        final notifications = state.notifications;

                        if (notifications.isEmpty) {
                          return Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/icon.svg',
                                  width: 238,
                                  height: 238,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text('لا يوجد اشعارات',
                                  style: TextStyle(
                                    color: MyColors.greyColor,
                                    fontFamily: "Noto Kufi Arabic",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 24.sp ,
                                  ),
                                )
                              ],
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: notifications.length,
                          itemBuilder: (context, index) {
                            final notif = notifications[index];
                            return GestureDetector(
                              onTap: (){
                                Navigator.of(context).pushReplacement(
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) => NotificationDetailsScreen(notificationId: notif.id ??'',),
                                    transitionDuration: Duration.zero,
                                    reverseTransitionDuration: Duration.zero,
                                  ),
                                );
                              },
                              child: NotificationCard(
                                title: notif.notification?.title ?? "",
                                body: notif.notification?.body ?? "",
                                date: notif.notification?.createdAt ??'',
                                  read: notif.read ?? false,
                              ),
                            );
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
