import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_college/View/Student/Profile/ProfileScreen.dart';
import 'package:smart_college/utils/colors.dart';
import 'package:smart_college/utils/result.dart';

import '../../../Cubits/States/States.dart';
import '../../../Cubits/Students/ProfileScreenViewModel.dart';
import '../../../utils/text_field.dart';
import 'DeleteDialog.dart';

class SettingScreen extends StatefulWidget{
  static const String routeName = 'setting';

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}


class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();


    context.read<ProfileViewModel>().getProfile();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(child: Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: Stack(
        children: [
          SvgPicture.asset('assets/images/Background.svg',
           // width: double.infinity,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => ProfileScreen(),
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
                      SizedBox(width: 20.w,),
                      Text('الاعدادات',
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

                  BlocListener<ProfileViewModel, States>(
                    listener: (context,States state){
                    //   if (state is UpdateProfileSuccessState) {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(content: Text("تم الحفظ بنجاح")),
                    //     );
                    //   }
                    },
                    child: BlocBuilder<ProfileViewModel, States>(

                      builder: (context,state) {
                        final viewModel = context.read<ProfileViewModel>();


                        if (state is LoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(color: MyColors.primaryColor),
                          );
                        }

                        if (state is ErrorState) {
                          return Center(child: Text(state.errorMessage ?? "حدث خطأ"));
                        }
                        return Container(
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
                                padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 15.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('اللغة',
                                      style: TextStyle(
                                        fontFamily: 'Noto Kufi Arabic',
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: MyColors.primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    buildLevelDropdown(viewModel),
                                    SizedBox(height: 10.h),
                                    TextFormField(
                                      readOnly: true, // لأنه مش قابل للكتابة
                                      decoration: InputDecoration(
                                        labelText: "الوضع الليلي",
                                        labelStyle: TextStyle(color: MyColors.primaryColor, fontSize: 12.sp,
                                            fontFamily: "Noto Kufi Arabic" , fontWeight: FontWeight.w500),
                                        contentPadding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 13.h),
                                        fillColor: MyColors.softWhiteColor,
                                        filled: true,
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.only(
                                            top: 18.sp,
                                            left: 6.sp,
                                            right: 6.sp,
                                            bottom: 18.sp,
                                          ),
                                          child: SvgPicture.asset(
                                            'assets/images/mode.svg',
                                          ),
                                        ),
                                        suffixIcon: Transform.scale(
                                          scale: 0.75, // 👈 لتصغير السويتش بحيث يتناسب مع حجم الأيقونات
                                          child: Switch(
                                            value: viewModel.isDarkMode,
                                            onChanged: (value) {
                                              setState(() {
                                                viewModel.isDarkMode = value;
                                              });
                                              // 🟢 هنا ممكن تضيفي لوجيك تفعيل الوضع الليلي فعليًا
                                            },
                                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // 👈 يمنع تمدد السويتش
                                            splashRadius: 0, // 👈 يلغي المؤثر عند الضغط
                                            thumbColor: WidgetStateProperty.all(Colors.white), // 👈 تثبيت لون الدائرة
                                            trackColor: WidgetStateProperty.resolveWith<Color>(
                                                  (Set<WidgetState> states) {
                                                if (states.contains(WidgetState.selected)) {
                                                  return MyColors.primaryColor; // اللون وقت التشغيل
                                                }
                                                return MyColors.greyColor; // اللون وقت الإغلاق
                                              },
                                            ),
                                          ),
                                        ),

                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.transparent), // إطار افتراضي
                                          borderRadius: BorderRadius.circular(10.r),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: const BorderSide(color: Colors.blue),
                                        ),
                                      ),
                                    ),



                                    SizedBox(height: 40.h),
                                    ElevatedButton(
                                      onPressed:(){
                                        showDialog(
                                          context: context,
                                          builder: (_) => DeleteDialog(
                                            message: "هل انت متاكد من انك تريد حذف الحساب ؟",
                                            image: "assets/images/delete.svg",
                                            overlayImage: "assets/images/sorry.svg",
                                          ),
                                        );

                                      },
                                      child: Text(
                                        "حذف الحساب",
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontFamily: "Noto Kufi Arabic",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: MyColors.deleteColor,
                                        foregroundColor: MyColors.whiteColor,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10.h,
                                          horizontal: 100.w,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.r),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 30.h),

                                    ElevatedButton(
                                      onPressed:(){
                                        //  final viewModel = context.read<ProfileViewModel>();
                                        viewModel.updateProfile();
                                      },
                                      child: Text(
                                        "حفظ",
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontFamily: "Noto Kufi Arabic",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: MyColors.primaryColor,
                                        foregroundColor: MyColors.whiteColor,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10.h,
                                          horizontal: 130.w,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.r),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );



                      },

                    ),
                  ),


                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  // Widget buildLevelDropdown(ProfileViewModel viewModel) {
  //   // اللغة الحالية
  //   String currentLang = viewModel.languageController.text.isEmpty
  //       ? 'العربية'
  //       : viewModel.languageController.text;
  //
  //   // اللغة المقابلة (اللي تظهر في القائمة)
  //   String otherLang = currentLang == 'العربية' ? 'الانجليزية' : 'العربية';
  //
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       // الحقل الرئيسي
  //       GestureDetector(
  //         onTap: () {
  //           setState(() {
  //             viewModel.showDropdownLanguage = !viewModel.showDropdownLanguage;
  //           });
  //         },
  //         child: AbsorbPointer(
  //           child: buildTextField(
  //             hint: currentLang, // اللغة الحالية تظهر هنا
  //             controller: viewModel.languageController,
  //             readonly: true,
  //             suffixIcon: Icon(
  //               viewModel.showDropdownLanguage
  //                   ? Icons.arrow_drop_up
  //                   : Icons.arrow_drop_down,
  //               size: 35.sp,
  //               color: MyColors.primaryColor,
  //             ),
  //             prefixIcon: Padding(
  //               padding: EdgeInsets.all(14),
  //               child: SvgPicture.asset(
  //                 'assets/images/globe.svg',
  //                 width: 10.sp,
  //                 height: 10.sp,
  //               ),
  //             ),
  //             validator: (String) {  },
  //           ),
  //         ),
  //       ),
  //
  //       // القائمة المنسدلة
  //       if (viewModel.showDropdownLanguage)
  //         GestureDetector(
  //           onTap: () {
  //             setState(() {
  //               // تبديل اللغة عند الضغط
  //               viewModel.languageController.text = otherLang;
  //               viewModel.showDropdownLanguage = false;
  //             });
  //           },
  //           child: Container(
  //             width: double.infinity,
  //             padding: EdgeInsets.all(15),
  //             decoration: BoxDecoration(
  //               border: Border.symmetric(
  //                 horizontal: BorderSide(color: MyColors.softGreyColor),
  //               ),
  //               color: MyColors.softWhiteColor,
  //             ),
  //             child: Row(
  //               children: [
  //                 SvgPicture.asset(
  //                   'assets/images/globe.svg',
  //                   width: 15.sp,
  //                   height: 15.sp,
  //                   colorFilter: ColorFilter.mode(
  //                     Color(0xFF7A7A7A),
  //                     BlendMode.srcIn,
  //                   ),
  //                 ),
  //                 SizedBox(width: 20.w),
  //                 Text(
  //                   otherLang,
  //                   style: TextStyle(
  //                     color: MyColors.greyColor,
  //                     fontFamily: "Noto Kufi Arabic",
  //                     fontWeight: FontWeight.w400,
  //                     fontSize: 12.sp,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //     ],
  //   );
  // }



  Widget buildLevelDropdown(ProfileViewModel viewModel) {
    // اللغة الحالية
    String currentLang = viewModel.languageController.text.isEmpty
        ? 'العربية'
        : viewModel.languageController.text;

    // اللغة الأخرى
    String otherLang = currentLang == 'العربية' ? 'الإنجليزية' : 'العربية';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // الحقل الرئيسي
        GestureDetector(
          onTap: () {
            setState(() {
              viewModel.showDropdownLanguage = !viewModel.showDropdownLanguage;
            });
          },
          child: AbsorbPointer(
            child: TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: currentLang, // يظهر هنا بالرمادي
                hintStyle: TextStyle(
                  color: MyColors.greyColor, // لون الرصاصي
                  fontFamily: "Noto Kufi Arabic",
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 13.h),
                fillColor: MyColors.softWhiteColor,
                filled: true,
                prefixIcon: Padding(
                  padding: EdgeInsets.all(14),
                  child: Icon(
                    Icons.language,
                    color: MyColors.primaryColor,
                    size: 20.sp,
                  ),
                ),
                suffixIcon: Icon(
                  viewModel.showDropdownLanguage
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down,
                  size: 35.sp,
                  color: MyColors.primaryColor,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: MyColors.primaryColor),
                ),
              ),
            ),
          ),
        ),

        // القائمة المنسدلة
        if (viewModel.showDropdownLanguage)
          GestureDetector(
            onTap: () {
              setState(() {
                viewModel.languageController.text = otherLang;
                viewModel.showDropdownLanguage = false;
              });
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(color: MyColors.softGreyColor),
                ),
                color: MyColors.softWhiteColor,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.language,
                    color: MyColors.greyColor,
                    size: 18.sp,
                  ),
                  SizedBox(width: 20.w),
                  Text(
                    otherLang,
                    style: TextStyle(
                      color: MyColors.greyColor,
                      fontFamily: "Noto Kufi Arabic",
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

}