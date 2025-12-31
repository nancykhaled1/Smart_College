import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_college/View/Student/Profile/ProfileScreen.dart';
import 'package:smart_college/View/Student/studentHomeScreen.dart';
import 'package:smart_college/View/widgets/common_top_search_bar.dart';
import 'package:smart_college/View/widgets/common_bottom_navigation.dart';

import '../../Cubits/Home/ChatScreenViewModel.dart';
import '../../Cubits/Home/NotificationDetailsViewModel.dart';
import '../../Cubits/Home/NotificationViewModel.dart';
import '../../services/local/sharedPreference.dart';
import '../Notification/notificationPermission.dart';
import '../Student/Materials&Exams/ExamScreen.dart';
import '../widgets/student_bottom_navigation.dart';
import 'accountType.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'homeScreen';
  
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  
  // قائمة الصفحات في الـ Bottom Navigation
  final List<Widget> _pages = [
    studentHomescreen(),                 // index 0 → الرئيسية
    Center(child: Text(' المواد الدراسية')), // index 1 → المواد
    Container(),                         // index 2 → مكان زرار الشات (فضي)
    Examscreen(),                        // index 3 → الامتحانات
    ProfileScreen(),                         // index 4 → حسابى
  ];


  @override
  void initState() {
    super.initState();
    _initNotifications();
    context.read<NotificationDetailsViewModel>().getCounter();
    _loadUserId();
   // _initChat();
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
   // NotificationPermissionHelper.requestNotificationPermission(context);
    final enabled = await TokenStorage.getNotificationPreference(); // من sharedPreference
    if (!enabled) {
      print("🔕 Notifications are disabled by user.");
      return;
    }

    context.read<NotificationCubit>().getFcmToken();
    context.read<NotificationCubit>().sendFcmToken();
    context.read<NotificationCubit>().listenToMessages();

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission();
    print("🔔 Permission status: ${settings.authorizationStatus}");


  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: Column(
        children: [
          // شريط البحث والإشعارات - مشترك في جميع الصفحات
          if (_currentIndex != 4) CommonTopSearchBar(),
          
          // محتوى الصفحات
          Expanded(
            child: _pages[_currentIndex],
          ),
        ],
      ),
      
      // Bottom Navigation Bar
      bottomNavigationBar: _currentIndex != 4
          ? StudentBottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      )
          : null,
    );
  }
}