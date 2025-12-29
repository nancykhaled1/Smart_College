import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:smart_college/utils/colors.dart';

import '../../Cubits/States/States.dart';
import '../../../../Cubits/Home/NotificationDetailsViewModel.dart';
import '../../Cubits/Students/ProfileScreenViewModel.dart';
import 'notification_screen.dart';

class NotificationDetailsScreen extends StatefulWidget {
  final String notificationId;
  static const String routeName = 'details';

  const NotificationDetailsScreen({Key? key, required this.notificationId})
    : super(key: key);

  @override
  State<NotificationDetailsScreen> createState() =>
      _NotificationDetailsScreenState();
}

class _NotificationDetailsScreenState extends State<NotificationDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationDetailsViewModel>().getNotificationDetails(
      widget.notificationId,
    );

    final profileCubit = context.read<ProfileViewModel>();
    profileCubit.getProfile(); // استدعاء بيانات البروفايل

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.backgroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder:
                          (context, animation, secondaryAnimation) =>
                              NotificationScreen(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(10.r),
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
              SizedBox(height: 30.h),
              BlocBuilder<ProfileViewModel, States>(
                builder: (context,state){
                  String userName = "الطالب"; // القيمة الافتراضية

                  if (state is ProfileSuccessState) {
                    userName = state.userProfile.name ?? "الطالب";
                  }
                  return BlocBuilder<NotificationDetailsViewModel, States>(
                    builder: (context, state) {
                      if (state is LoadingState) {
                        return Expanded(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: MyColors.primaryColor,
                            ),
                          ),
                        );
                      } else if (state is NotificationDetailsSuccessState) {
                        final details =
                            state
                                .notificationDetails; // ده الريسبونس اللى جاي من الباك
                        final parsedDate =
                        DateTime.parse(details.createdAt!).toLocal();
                        final formattedDate = DateFormat(
                          'HH:mm – dd/MM/yyyy',
                        ).format(parsedDate);



                        return Container(
                          decoration: BoxDecoration(
                            color: MyColors.whiteColor,
                            borderRadius: BorderRadius.circular(15.r),
                            boxShadow: [
                              BoxShadow(
                                color: MyColors.shadowGreyColor.withOpacity(0.25),
                                blurRadius: 15,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: MyColors.shadowGreyColor,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(7.r),
                                          topLeft: Radius.circular(7.r),
                                          bottomRight: Radius.circular(7.r),
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 8.h,
                                        horizontal: 10.w,
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/images/notification2.svg',
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 10.w),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "مرحبا $userName",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontFamily: "Noto Kufi Arabic",
                                              fontWeight: FontWeight.w500,
                                              color: MyColors.softBlackColor,
                                            ),
                                          ),
                                          SizedBox(height: 10.h),
                                          Text(
                                            formattedDate,
                                            style: TextStyle(
                                              fontSize: 9.sp,
                                              fontFamily: "Noto Kufi Arabic",
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.shadowColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  details.notification?.title ?? '',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontFamily: "Noto Kufi Arabic",
                                    fontWeight: FontWeight.w500,
                                    color: MyColors.blackColor,
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  details.notification?.body ?? '',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: "Noto Kufi Arabic",
                                    fontWeight: FontWeight.w500,
                                    color: MyColors.softBlackColor,
                                    height: 1.7.h,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else if (state is ErrorState) {
                        return Center(
                          child: Text("Error: ${state.errorMessage}"),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
