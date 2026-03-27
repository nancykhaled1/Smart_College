import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_college/View/Student/Profile/MyProfileScreen.dart';
import 'package:smart_college/View/Student/Profile/SettingScreen.dart';
import 'package:smart_college/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../Cubits/Home/NotificationViewModel.dart';
import '../../../Cubits/States/States.dart';
import '../../../Cubits/Students/ProfileScreenViewModel.dart';
import '../../../services/local/sharedPreference.dart';
import '../../Auth/Register/roleselection.dart';
import '../../Graduated/home/graduatedHomeScreen.dart';
import '../../Notification/notificationPermission.dart';
import '../../home/accountType.dart';
import '../../home/homeScreen.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = 'profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();

    context.read<ProfileViewModel>().getProfile();
   // context.read<NotificationCubit>().loadNotificationPreference();
    context.read<NotificationCubit>().listenToMessages();



  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ProfileViewModel>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.backgroundColor,
        body: Stack(
          children: [
            SvgPicture.asset('assets/images/Background.svg',
             // width: double.infinity,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final role = await TokenStorage.getRole();
                          if(role == 'Student'){
                            Navigator.of(context).pushReplacement(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                    HomeScreen(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          } else if (role == 'Graduated'){
                            Navigator.of(context).pushReplacement(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        GraduatedHomeScreen(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          }
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
                      SizedBox(width: 20.w),
                      Text(
                        'حسابي',
                        style: TextStyle(
                          fontFamily: 'Noto Kufi Arabic',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: MyColors.softBlackColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 100.h),

                  Stack(
                    clipBehavior:
                        Clip.none, // 👈 ده مهم جدًا عشان الصورة تطلع برا
                    children: [
                      /// 🟢 الكونتينر اللي فيه الاسم والايميل
                      Container(
                        width: double.infinity,
                        // margin: EdgeInsets.only(bottom: 40.h), // 👈 نسيب مساحة للصورة فوق
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: BlocBuilder<ProfileViewModel, States>(
                          builder: (context, state) {
                            final cubit = context.read<ProfileViewModel>();

                            if (state is LoadingState) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: MyColors.primaryColor,
                                ),
                              );
                            } else if (state is ErrorState) {
                              return Text(
                                'حدث خطأ أثناء تحميل البيانات',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 13.sp,
                                ),
                              );
                            } else {
                              return Column(
                                children: [
                                  SizedBox(height: 15.h),
                                  Text(
                                    cubit.userNameController.text.isNotEmpty
                                        ? cubit.userNameController.text
                                        : ' ',
                                    style: TextStyle(
                                      fontFamily: 'Noto Kufi Arabic',
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500,
                                      color: MyColors.softBlackColor,
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  Text(
                                    cubit.emailController.text.isNotEmpty
                                        ? cubit.emailController.text
                                        : '',
                                    style: TextStyle(
                                      fontFamily: 'Noto Kufi Arabic',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: MyColors.greyColor,
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ),

                      /// 🧍‍♀️ الصورة تطلع فوق الكونتينر
                      Positioned(
                        top: -65.h, // 👈 تتحكم في الارتفاع من فوق
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: MyColors.primaryColor.withOpacity(
                              0.15,
                            ), // 🎨 لون الخلفية الافتراضي
                            boxShadow: [
                              BoxShadow(
                                color: MyColors.greyColor,
                                blurRadius: 4,
                                spreadRadius: 0,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: BlocBuilder<ProfileViewModel, States>(
                            builder: (context, state) {
                              final cubit = context.read<ProfileViewModel>();

                              String? imageUrl = cubit.profileImageUrl;

                              // if (state is LoadingState) {
                              //   return const Center(
                              //     child: CircularProgressIndicator(
                              //       color: MyColors.primaryColor,
                              //     ),
                              //   );
                              // }

                              return CircleAvatar(
                                radius: 50.r,
                                backgroundColor: MyColors.whiteColor,
                                child: ClipOval(
                                  child: imageUrl != null && imageUrl.isNotEmpty
                                      ? Image.network(
                                    "$imageUrl?v=${DateTime.now().millisecondsSinceEpoch}",
                                    key: UniqueKey(),
                                    fit: BoxFit.cover,
                                    width: 100.w,
                                    height: 100.h,
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          color: MyColors.primaryColor,
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) =>
                                        Image.asset('assets/images/Ellipse.png',
                                            fit: BoxFit.fill,
                                            width: 100.w,
                                            height: 100.h
                                        ),
                                  )
                                      : Image.asset(
                                    'assets/images/Ellipse.png',
                                    fit: BoxFit.cover,
                                    width: 100.w,
                                    height: 100.h,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  /// 🧾 القائمة
                  Container(
                    width: double.infinity,
                    // margin: EdgeInsets.only(bottom: 40.h), // 👈 نسيب مساحة للصورة فوق
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 20.h,
                        horizontal: 15.w,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/person-profile.svg',
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                'الملف الشخصى',
                                style: TextStyle(
                                  fontFamily: 'Noto Kufi Arabic',
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                  color: MyColors.softBlackColor,
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (
                                            context,
                                            animation,
                                            secondaryAnimation,
                                          ) => MyProfileScreen(),
                                      transitionDuration: Duration.zero,
                                      reverseTransitionDuration: Duration.zero,
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 20.sp,
                                ),
                                color: MyColors.primaryColor,
                              ),
                            ],
                          ),
                          Divider(thickness: 1, color: MyColors.softGreyColor),
                          Row(
                            children: [
                              SvgPicture.asset('assets/images/setting.svg'),
                              SizedBox(width: 10.w),
                              Text(
                                'الاعدادات',
                                style: TextStyle(
                                  fontFamily: 'Noto Kufi Arabic',
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                  color: MyColors.softBlackColor,
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (
                                            context,
                                            animation,
                                            secondaryAnimation,
                                          ) => SettingScreen(),
                                      transitionDuration: Duration.zero,
                                      reverseTransitionDuration: Duration.zero,
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 20.sp,
                                ),
                                color: MyColors.primaryColor,
                              ),
                            ],
                          ),
                          Divider(thickness: 1, color: MyColors.softGreyColor),
                          Row(
                            children: [
                              SvgPicture.asset('assets/images/notif.svg'),
                              SizedBox(width: 10.w),
                              Text(
                                'الاشعارات',
                                style: TextStyle(
                                  fontFamily: 'Noto Kufi Arabic',
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                  color: MyColors.softBlackColor,
                                ),
                              ),
                              Spacer(),
                              BlocBuilder<NotificationCubit, States>(
                                builder: (context, state) {
                                  final cubit = context.read<NotificationCubit>();
                                  return Transform.scale(
                                    scale: 0.75,
                                    child: Switch(
                                      value: cubit.muteNotifications,
                                      onChanged: (value) {

                                           // cubit.toggleMute(value)
                                      },

                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      splashRadius: 0,
                                      thumbColor: WidgetStateProperty.all(Colors.white),
                                      trackColor: WidgetStateProperty.resolveWith<Color>(
                                            (states) => states.contains(WidgetState.selected)
                                            ? MyColors.primaryColor
                                            : MyColors.greyColor,
                                      ),
                                    ),
                                  );
                                },
                              ),

                            ],
                          ),
                          Divider(thickness: 1, color: MyColors.softGreyColor),
                          Row(
                            children: [
                              SvgPicture.asset('assets/images/text-.svg'),
                              SizedBox(width: 10.w),
                              Text(
                                'الشروط و الاحكام',
                                style: TextStyle(
                                  fontFamily: 'Noto Kufi Arabic',
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                  color: MyColors.softBlackColor,
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  // Navigator.pushReplacement(
                                  //   context,
                                  //   MaterialPageRoute(builder: (_) => GraduatedHomeScreen()),
                                  // );
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 20.sp,
                                ),
                                color: MyColors.primaryColor,
                              ),
                            ],
                          ),
                          Divider(thickness: 1, color: MyColors.softGreyColor),
                          Row(
                            children: [
                              SvgPicture.asset('assets/images/call-center.svg'),
                              SizedBox(width: 10.w),
                              Text(
                                'مركز المساعدة',
                                style: TextStyle(
                                  fontFamily: 'Noto Kufi Arabic',
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                  color: MyColors.softBlackColor,
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  // Navigator.pushReplacement(
                                  //   context,
                                  //   MaterialPageRoute(builder: (_) => GraduatedHomeScreen()),
                                  // );
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 20.sp,
                                ),
                                color: MyColors.primaryColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  Container(
                    width: double.infinity,
                    // margin: EdgeInsets.only(bottom: 40.h), // 👈 نسيب مساحة للصورة فوق
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              viewModel.logout(context);
                            },
                            icon: Icon(Icons.logout, size: 20.sp),
                            color: MyColors.redColor,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            'تسجيل الخروج',
                            style: TextStyle(
                              fontFamily: 'Noto Kufi Arabic',
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: MyColors.redColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
