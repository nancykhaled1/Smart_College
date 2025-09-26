import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_college/View/Auth/Register/roleselection.dart';
import 'package:smart_college/View/SmartChat/SmartChat.dart';
import 'package:smart_college/View/Student/Materials&Exams/ExamScreen.dart';
import 'package:smart_college/utils/colors.dart';
import '../../../Cubits/States/States.dart';
import '../../../Cubits/Home/NotificationDetailsViewModel.dart';
import '../../../Cubits/Home/NotificationViewModel.dart';
import '../../../services/local/sharedPreference.dart';
import '../../Notification/notificationPermission.dart';
import '../../Notification/notification_screen.dart';
import '../../SmartChat/Socket.dart';

class StudentHomeScreen extends StatefulWidget {
  static const String routeName = 'studentHome';

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}


class _StudentHomeScreenState extends State<StudentHomeScreen> {


  @override
  void initState() {
    super.initState();
    _initNotifications();
    context.read<NotificationDetailsViewModel>().getCounter();
    _loadUserId();
  }

  void _loadUserId() async {
    final userId = await TokenStorage.getUserId();
    print("User ID in Home: $userId");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // هيتنفذ كل مرة ترجع للشاشة
    context.read<NotificationDetailsViewModel>().getCounter();
  }

  Future<void> _initNotifications() async {
    NotificationPermissionHelper.requestNotificationPermission(context);
    context.read<NotificationCubit>().getFcmToken();
    context.read<NotificationCubit>().sendFcmToken();
    context.read<NotificationCubit>().listenToMessages();
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission();
    print("🔔 Permission status: ${settings.authorizationStatus}");

  }


  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // مسح كل البيانات المخزنة (token, role, ...)

    // رجوع لشاشة اللوجين
    Navigator.pushReplacementNamed(context,AccountType.routeName);
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        // هنا بتتحكمى هل ترجعى ولا لا
        return false; // ❌ مش هيرجع
        // return true;  ✅ هيرجع
      },
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => NotificationScreen(),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: MyColors.whiteColor,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/notification.svg',
                                  color: MyColors.softBlackColor,
                                ),

                                // 🔴 البادج (Counter)
                                Positioned(
                                  right: 20.w,
                                  top: -13.h,
                                  child: BlocBuilder<NotificationDetailsViewModel, States>(
                                    builder: (context, state)  {
                                      int counter = 0;
                                      if (state is LoadingState) {
                                        return Container(
                                          padding: EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: MyColors.primaryColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: SizedBox(
                                            height: 10,
                                            width: 10,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Colors.white,
                                            ),
                                          ),
                                        );
                                      }

                                      if (state is CounterSuccessState)  {

                                        counter = state.counterData.unreadCount ?? 0;
                                      }

                                      if (counter == 0) return SizedBox(); // لو مفيش إشعارات مخليهوش يظهر

                                      return Container(
                                        padding: EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: MyColors.primaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          "$counter",
                                          style: TextStyle(
                                            fontFamily: 'Noto Kufi Arabic',
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final savedToken = await TokenStorage.getToken();
                        print("Token used: $savedToken");

                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => ChatScreen(),
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
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout),
                      onPressed: () => logout(context),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  // height: 200,
                  // width: 400,
                  decoration: BoxDecoration(
                    color: MyColors.whiteColor,
                    border: Border.all(color: Colors.blue, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset('assets/images/graduation-cap.svg'),
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            "الطاالب",
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: MyColors.softBlackColor,
                                fontWeight: FontWeight.w500 ,
                                fontFamily: 'Noto Kufi Arabic'
                            ),
                          ),
                          Spacer(),
                          SvgPicture.asset('assets/images/Rectangle.svg'),
                        ],
                      ),
                      SizedBox(height: 20.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildCircle("30%", "دراسات عليا", 0.3,
                              [MyColors.pnkcolor , MyColors.pnkcolor2]
                          ),
                          _buildCircle("66%", "عامل حر", 0.66, [MyColors.pnkcolor , MyColors.pnkcolor2]),
                          _buildCircle("85%", "موظف", 0.85, [MyColors.pnkcolor , MyColors.pnkcolor2]),
                          _buildCircle("90%", "باحث عن عمل", 0.9, [MyColors.pnkcolor , MyColors.pnkcolor2]),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        "عرض المزيد",
                        style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => Examscreen(),
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
                      Icons.text_snippet_outlined,
                      color: MyColors.primaryColor,
                    ),
                  ),
                ),


              ],
            ),

          ),
        ),
      ),
    );
  }

  Widget _buildCircle(String percentText, String label, double percent, List<Color> gradientColors) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 40.0,
          lineWidth: 6.0,
          percent: percent,
          center: Text(
            percentText,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          linearGradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          backgroundColor: Colors.grey.shade300,
          circularStrokeCap: CircularStrokeCap.round,
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}
