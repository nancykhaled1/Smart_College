import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_college/View/Student/studentHomeScreen.dart';
import 'package:smart_college/View/widgets/common_top_search_bar.dart';
import 'package:smart_college/View/widgets/common_bottom_navigation.dart';

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
    studentHomescreen(), // الصفحة الرئيسية للطالب
    Container(child: Center(child: Text(' دراسات عليا '))), // يمكن استبدالها بصفحة أخرى
    Container(child: Center(child: Text(' التدريبات'))), // يمكن استبدالها بصفحة أخرى
    Container(child: Center(child: Text(' Dashboard'))), // يمكن استبدالها بصفحة أخرى
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: Column(
        children: [
          // شريط البحث والإشعارات - مشترك في جميع الصفحات
          CommonTopSearchBar(),
          
          // محتوى الصفحات
          Expanded(
            child: _pages[_currentIndex],
          ),
        ],
      ),
      
      // Bottom Navigation Bar
      bottomNavigationBar: CommonBottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}