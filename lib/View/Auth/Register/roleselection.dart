import 'package:flutter/material.dart';
import 'package:smart_college/View/Auth/Register/studentRegister.dart';

import 'alumniRegister.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});
  static const String routeName = 'role';


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // هنا بتتحكمى هل ترجعى ولا لا
        return false; // ❌ مش هيرجع
        // return true;  ✅ هيرجع
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "اختر نوع الحساب",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Noto Kufi Arabic",
                  ),
                ),
                const SizedBox(height: 40),

                // زر الطالب
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => StudentRegisterScreen(role: "Student"),
                      ),
                    );
                  },
                  child: const Text("طالب"),
                ),

                const SizedBox(height: 20),

                // زر الخريج
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AlumniRegisterScreen(role: "Graduated"),
                      ),
                    );
                  },
                  child: const Text("خريج"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
