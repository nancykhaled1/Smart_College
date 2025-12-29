import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_college/utils/colors.dart';

class buildTextField extends StatelessWidget {
  String hint;
  TextInputType keyboardType;
  TextEditingController controller;
  String? Function(String?) validator;
  bool isPassword;
  bool isobscure;
  Widget? suffixIcon;
  Widget? prefixIcon;
  void Function()? suffixIconFunction;
  bool readonly;
  String label;


  buildTextField({
    required this.hint,
    this.keyboardType = TextInputType.text,
    required this.controller,
    required this.validator,
    this.isPassword = false,
    this.suffixIcon,
    this.prefixIcon,
    this.isobscure = false,
    this.suffixIconFunction,
    this.readonly = false,
    this.label = '',

  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readonly,
      textAlign: TextAlign.right,
      controller: controller,
      style: TextStyle(
        color: MyColors.greyColor, // 🔹 لون النص
        fontFamily: 'Noto Kufi Arabic',
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),

      validator: validator,
      keyboardType: keyboardType,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: MyColors.primaryColor, fontSize: 12.sp,
            fontFamily: "Noto Kufi Arabic" , fontWeight: FontWeight.w500),
        contentPadding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 13.h),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        fillColor: MyColors.softWhiteColor,
        filled: true,
        hintText: hint,
        hintStyle: TextStyle(color: MyColors.primaryColor, fontSize: 12.sp,
            fontFamily: "Noto Kufi Arabic" , fontWeight: FontWeight.w400),
        prefixIcon: prefixIcon,
        suffixIcon:
        suffixIcon != null
            ? InkWell(onTap: suffixIconFunction, child: suffixIcon)
            : null,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent), // إطار افتراضي
          borderRadius: BorderRadius.circular(10.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors.primaryColor, width: 2), // عند التركيز
          borderRadius: BorderRadius.circular(10.r),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFA90714), width: 2), // لون الخطأ
          borderRadius: BorderRadius.circular(10.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFA90714), width: 2), // عند التركيز مع خطأ
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }
}
