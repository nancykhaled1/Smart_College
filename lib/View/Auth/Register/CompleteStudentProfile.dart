import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_college/View/Student/Home/StudentHomeScreen.dart';
import 'package:smart_college/View/home/homeScreen.dart';
import 'package:smart_college/utils/colors.dart';

import '../../../Cubits/Auth/Register/States.dart';
import '../../../Cubits/Auth/Register/SyudentRegisterViewModel.dart';
import '../../../utils/dialog.dart';
import '../../../utils/text_field.dart';

class CompleteProfile extends StatefulWidget {
  final String? email;
  final String? name;

  const CompleteProfile({Key? key, this.email, this.name}) : super(key: key);
  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterErrorState) {
          showOverlayMessage(context, state.errorMessage!, isError: true);
        } else if (state is ProfileSuccessState) {
          showOverlayMessage(context, state.response.data!.message!, isError: false);
         // final userId = state.response.data?.userId; // استبدل بالاسم المناسب
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        final viewModel = context.read<RegisterCubit>();
        return WillPopScope(
          onWillPop: () async {
            // هنا بتتحكمى هل ترجعى ولا لا
            return false; // ❌ مش هيرجع
            // return true;  ✅ هيرجع
          },
          child: SafeArea(
            child: Scaffold(
              backgroundColor: MyColors.whiteColor,
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 50.h,bottom: 20.h),
                        child: SvgPicture.asset('assets/images/logo.svg'),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text('قم بتكملة بياناتك لانشاء حسابك',
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: MyColors.greyColor,
                            fontFamily: 'Noto Kufi Arabic',
                            fontWeight: FontWeight.w400
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Form(
                        key: viewModel.profileFormKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                                  SizedBox(height: 20.h),
                                  _buildLevelDropdown(viewModel),
                                  SizedBox(height: 20.h),
                                  _buildDepartmentDropdown(viewModel),
                            SizedBox(height: 40.h),
                                  ElevatedButton(
                              onPressed:
                              state is RegisterLoadingState
                                  ? null // منع الضغط أثناء التحميل
                                  : () {
                                viewModel.completeProfile();

                              },
                              child:
                              state is RegisterLoadingState
                                  ? SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor:
                                  AlwaysStoppedAnimation<Color>(
                                    MyColors.whiteColor,
                                  ),
                                ),
                              )
                                  : Text(
                                "انشاء الحساب",
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
                                  horizontal: 105.w,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                            ),

                                ],
                              ),
                      ),
                    ],
                  ),
                      ),


                  ),
                ),
              ),
            );

  });
  }


  Widget _buildLevelDropdown(RegisterCubit viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // الحقل الرئيسي
        GestureDetector(
          onTap: () {
            setState(() {
              viewModel.showDropdownlevel = !viewModel.showDropdownlevel;
            });
          },
          child: AbsorbPointer(
            child: buildTextField(
              hint: 'السنة الدراسيه',
              controller: viewModel.levelController,
              readonly: true,
              suffixIcon: Icon(
                viewModel.showDropdownlevel
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down, // تغيير الأيقونة
                size: 35.sp,
                color: MyColors.primaryColor,
              ),
              validator: (text) {
                if (text == null || text.isEmpty || text
                    .trim()
                    .isEmpty) {
                  return 'برجاء اختيار السنه الدراسيه';
                }
                return null;
              },
              prefixIcon: Padding(
                padding: EdgeInsets.all(14),
                child:
                SvgPicture.asset(
                  'assets/images/level.svg',
                  width: 10.sp,
                  height: 10.sp,
                ),
              ),
            ),
          ),
        ),

        // القائمة المنسدلة
        if (viewModel.showDropdownlevel)
          Column(
            children:
            viewModel.levelsList.map((item) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    viewModel.levelController.text = item.levelNumber.toString();
                    viewModel.showDropdownlevel = false;
                  });
                },

                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(color: MyColors.softGreyColor),
                    ),
                    // borderRadius: BorderRadius.circular(10.r),
                    color: MyColors.softWhiteColor,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/level.svg',
                        width: 15.sp,
                        height: 15.sp,
                        colorFilter: ColorFilter.mode(
                          Color(0xFF7A7A7A),
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Text(
                        item.levelNumber.toString(),
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
              );
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildDepartmentDropdown(RegisterCubit viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // الحقل الرئيسي
        GestureDetector(
          onTap: () {
            setState(() {
              viewModel.showDropdowndepartment =
              !viewModel.showDropdowndepartment;
            });
          },
          child: AbsorbPointer(
            child: buildTextField(
              hint: 'القسم',
              controller: viewModel.departmentController,
              readonly: true,
              suffixIcon: Icon(
                viewModel.showDropdowndepartment
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down, // تغيير الأيقونة
                size: 35.sp,
                color: MyColors.primaryColor,
              ),
              validator: (text) {
                if (text == null || text.isEmpty || text
                    .trim()
                    .isEmpty) {
                  return 'برجاء اختيار القسم';
                }
                return null;
              },
              prefixIcon: Padding(
                padding: EdgeInsets.all(10.sp),
                child: SvgPicture.asset(
                  'assets/images/book-open.svg',

                ),
              ),
            ),
          ),
        ),

        // القائمة المنسدلة
        if (viewModel.showDropdowndepartment)
          Column(
            children:
            viewModel.department.map((status) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    viewModel.departmentController.text = status.name ?? '';
                    viewModel.showDropdowndepartment = false;
                  });
                },

                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.symmetric(horizontal: BorderSide(
                        color: MyColors.softGreyColor
                    )),
                    // borderRadius: BorderRadius.circular(10.r),
                    color: MyColors.softWhiteColor,
                  ),
                  child: Row(
                    children: [
                      // SvgPicture.asset(
                      //   'assets/images/globe-alt.svg',
                      //   width: 18.sp,
                      //   height: 18.sp,
                      //   // colorFilter: ColorFilter.mode(
                      //   //   Color(0xFF7A7A7A),
                      //   //   BlendMode.srcIn,
                      //   // ),
                      // ),
                      SizedBox(width: 20.w),
                      Text(
                        status.name ??'',
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
              );
            }).toList(),
          ),
      ],
    );
  }
}