import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_college/View/Auth/Login/login.dart';
import 'package:smart_college/View/Auth/Register/verifyEmail.dart';
import 'package:smart_college/utils/colors.dart';
import 'package:smart_college/utils/text_field.dart';

import '../../../Cubits/Auth/Login/GoogleViewModel.dart';
import '../../../Cubits/States/States.dart';
import '../../../Cubits/Auth/Register/AlumniRegisterViewModel.dart';
import '../../../Cubits/Auth/Register/States.dart';
import '../../../services/local/sharedPreference.dart';
import '../../../utils/dialog.dart';
import '../../Graduated/home/graduatedHomeScreen.dart';
import '../../Onboarding/onboarding.dart';
import '../../Student/Home/StudentHomeScreen.dart';

class AlumniRegisterScreen extends StatefulWidget{
  static const String routeName = 'alumniRegister';
  final String role;
  const AlumniRegisterScreen({super.key, required this.role});

  @override
  State<AlumniRegisterScreen> createState() => _LoginScreenState();
}




class _LoginScreenState extends State<AlumniRegisterScreen> {

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<AlumniRegisterCubit>();
    return BlocConsumer<AlumniRegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterErrorState) {
          showOverlayMessage(context, state.errorMessage!, isError: true);

        } else if (state is AlumniRegisterSuccessState) {
          showOverlayMessage(context, state.response.data!.message!, isError: false);
          final userId = state.response.data?.userId;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerifyEmail(userId: userId!),
            ),
          );
        }
      },
      builder: (context, state) {

        return WillPopScope(
          onWillPop: () async {
            // هنا بتتحكمى هل ترجعى ولا لا
            return false; // ❌ مش هيرجع
            // return true;  ✅ هيرجع
          },
          child: SafeArea(
            child: Scaffold(
              backgroundColor: MyColors.whiteColor,
              body:SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 50.h,bottom: 20.h),
                        child: SvgPicture.asset('assets/images/logo.svg'),
                      ),
                      Text('مرحبا بك !',
                        style: TextStyle(
                            fontSize: 24.sp,
                            color: MyColors.softBlackColor,
                            fontFamily: 'Noto Kufi Arabic',
                            fontWeight: FontWeight.w400
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text('قم بادخال بيانتك لانشاء حسابك',
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
                        key: viewModel.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            buildTextField(
                              keyboardType: TextInputType.text,
                              hint: 'الاسم',
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(
                                  top: 18.sp,
                                  left: 6.sp,
                                  right: 6.sp,
                                  bottom: 18.sp,
                                ),
                                child: SvgPicture.asset(
                                  'assets/images/user.svg', // الأيقونة الافتراضية
                                  // width: 15.sp,
                                  // height: 15.sp,
                                  // colorFilter: ColorFilter.mode(
                                  //   MyColors.greyColor,
                                  //   BlendMode.srcIn,
                                  // ),
                                ),
                              ),
                              controller: viewModel.userNameController,
                              validator: (text) {
                                if (text!.isEmpty || text.trim().isEmpty) {
                                  return 'برجاء ادخال اسمك';
                                } return null;
                              },
                            ),
                            SizedBox(height: 20.h),
                            buildTextField(
                              keyboardType: TextInputType.emailAddress,
                              hint: 'البريد الالكتروني',
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(
                                  top: 18.sp,
                                  left: 6.sp,
                                  right: 6.sp,
                                  bottom: 18.sp,
                                ),
                                child: SvgPicture.asset(
                                  'assets/images/mail.svg',
                                  // width: 10.sp,
                                  // height: 10.sp,
                                  // colorFilter: ColorFilter.mode(
                                  //   MyColors.greyColor,
                                  //   BlendMode.srcIn,
                                  // ),
                                ),
                              ),
                              controller: viewModel.emailController,
                              validator: (text) {
                                if (text!.isEmpty || text.trim().isEmpty) {
                                  return 'برجاء ادخال البريد الالكترونى';
                                }
                                bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                                ).hasMatch(text);
                                if (!emailValid) {
                                  return 'برجاء ادخال بريد الكتروني صحيح';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.h),
                            buildTextField(
                              keyboardType: TextInputType.visiblePassword,
                              hint: 'كلمة المرور',
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(
                                  top: 18.sp,
                                  left: 6.sp,
                                  right: 6.sp,
                                  bottom: 18.sp,
                                ),
                                child: SvgPicture.asset(
                                  'assets/images/lock.svg', // الأيقونة الافتراضية
                                  // width: 15.sp,
                                  // height: 15.sp,
                                ),
                              ),
                              isPassword: viewModel.isPasswordVisible,
                              suffixIcon: Icon(
                                viewModel.isPasswordVisible
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: 18.sp,
                                color: MyColors.primaryColor,
                              ),
                              suffixIconFunction: () {
                                setState(() {
                                  viewModel.isPasswordVisible = !viewModel.isPasswordVisible;
                                });
                              },
                              controller: viewModel.passwordController,
                              validator: (text) {
                                if (text!.isEmpty || text.trim().isEmpty) {
                                  return 'برجاء ادخال كلمة المرور';
                                }
                                if (text.length < 6) {
                                  return 'كلمة المرور يجب ألا تقل عن 6 احرف';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.h),
                            buildTextField(
                              keyboardType: TextInputType.visiblePassword,
                              hint: 'تأكيد كلمة المرور',
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(
                                  top: 18.sp,
                                  left: 6.sp,
                                  right: 6.sp,
                                  bottom: 18.sp,
                                ),
                                child: SvgPicture.asset(
                                  'assets/images/lock.svg', // الأيقونة الافتراضية
                                  // width: 15.sp,
                                  // height: 15.sp,
                                ),
                              ),
                              isPassword: viewModel.isRePasswordVisible,
                              suffixIcon: Icon(
                                viewModel.isRePasswordVisible
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: 18.sp,
                                color: MyColors.primaryColor,
                              ),
                              suffixIconFunction: () {
                                setState(() {
                                  viewModel.isRePasswordVisible = !viewModel.isRePasswordVisible;
                                });
                              },
                              controller: viewModel.rePasswordController,
                              validator: (text) {
                                if (text == null || text.isEmpty)
                                  return 'يرجى تأكيد كلمة المرور';
                                if (text != viewModel.passwordController.text)
                                  return 'كلمة المرور غير متطابقة';
                                return null;
                              },
                            ),
                            SizedBox(height: 20.h),
                            _buildResumeUploadField(viewModel),
                            SizedBox(height: 20.h),
                            _buildEmploymentStatusDropdown(viewModel),
                            SizedBox(height: 20.h),
                            if (viewModel.selectedEmploymentStatus == "موظف") ...[
                            buildTextField(
                              keyboardType: TextInputType.text,
                              hint: 'اسم الوظيفة',
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(10.sp),
                                child: SvgPicture.asset(
                                  'assets/images/first-aid.svg', // الأيقونة الافتراضية

                                  // colorFilter: ColorFilter.mode(
                                  //   MyColors.greyColor,
                                  //   BlendMode.srcIn,
                                  // ),
                                ),
                              ),
                              controller: viewModel.jobTitleController,
                              validator: (text) {
                                if (text!.isEmpty || text.trim().isEmpty) {
                                  return 'برجاء ادخال اسم الوظيفة';
                                }
                                return null;
                              },

                            ),
                            SizedBox(height: 20.h),
                            _buildDropdown(viewModel),
                            SizedBox(height: 20.h),
                            buildTextField(
                              keyboardType: TextInputType.text,
                              hint: 'رابط الشركة',
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(10.sp),
                                child: SvgPicture.asset(
                                  'assets/images/link.svg', // الأيقونة الافتراضية

                                  // colorFilter: ColorFilter.mode(
                                  //   Color(0xFF7A7A7A),
                                  //   BlendMode.srcIn,
                                  // ),
                                ),
                              ),
                              controller: viewModel.companyLinkController,
                              validator: (text) {
                                if (text!.isEmpty || text.trim().isEmpty) {
                                  return 'برجاءادخال رابط الشركة';
                                }
                                return null;
                              },
                            ),
                          ],

                            SizedBox(height: 40.h),
                            ElevatedButton(
                              onPressed: state is RegisterLoadingState
                                  ? null // منع الضغط أثناء التحميل
                                  : () {
                                viewModel.registerAlumni(role: widget.role);
                              },
                              child: state is RegisterLoadingState
                                  ? SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(MyColors.whiteColor),
                                ),
                              )
                                  :  Text(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('لديك حساب بالفعل؟',
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: MyColors.greyColor,
                                fontFamily: 'Noto Kufi Arabic',
                                fontWeight: FontWeight.w400
                            ),
                          ),
                          TextButton(onPressed: (){
                            Navigator.pushReplacementNamed(
                              context,
                              LoginScreen.routeName,
                            );
                          },
                            child: Text('سجل الان',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor: MyColors.primaryColor,
                                  fontSize: 12.sp,
                                  color: MyColors.primaryColor,
                                  fontFamily: 'Noto Kufi Arabic',
                                  fontWeight: FontWeight.w500
                              ),
                            ),)
                        ],
                      ),

                      SizedBox(
                        height: 30.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: MyColors.greyColor,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0), // مسافة يمين وشمال
                            child: Text(
                              'أو',
                              style: TextStyle(
                                fontSize: 12,
                                color: MyColors.greyColor,
                                fontFamily: 'Noto Kufi Arabic',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: MyColors.greyColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      BlocConsumer<GoogleCubit, States>(
                        listener: (context, state) async {
                          if (state is LoadingState) {
                            showOverlayMessage(context, "جارى التحميل", isError: false);
                          } else if (state is ErrorState) {
                            showOverlayMessage(context, state.errorMessage!, isError: true);
                          } else if (state is GoogleSuccessState) {
                            showOverlayMessage(context, "تم التسجيل بنجاح", isError: false);
                            final role = await TokenStorage.getRole();
                            if (role == "Student") {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => StudentHomeScreen()),
                              );
                            } else if (role == "Graduated") {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => GraduatedHomeScreen()),
                              );
                            } else {
                              // default fallback
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => OnBoarding()),
                              );
                            }
                          }
                        },
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: state is LoadingState
                                ? null
                                : () async{
                              final role = await TokenStorage.getRole();

                              context.read<GoogleCubit>().signInWithGoogle(
                                  role:widget.role
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/images/Google.svg'),
                                SizedBox(width: 10.w),
                                Text(
                                  "سجل باستخدام جوجل",
                                  style: TextStyle(
                                    color: MyColors.primaryColor,
                                    fontSize: 15.sp,
                                    fontFamily: "Noto Kufi Arabic",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.softWhiteColor,
                              padding: EdgeInsets.symmetric(
                                vertical: 10.h,
                                horizontal: 70.w,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              elevation: 5,
                              shadowColor: MyColors.shadGreyColor,
                            ),
                          );
                        },
                      ),

                    ],
                  ),
                ),
              ) ,
            ),
          ),
        );
      },
    );





  }

  Widget _buildResumeUploadField(AlumniRegisterCubit viewModel) {
    return buildTextField(

      hint: 'السيرة الذاتية',
      controller: viewModel.cvController,
      validator: (text) {
        if (viewModel.resumeFile == null) {
          return 'يرجى تحميل السيرة الذاتية';
        }
        return null;
      },


      prefixIcon: Padding(
        padding: EdgeInsets.only(
          top: 10.sp,
          left: 5.sp,
          right: 5.sp,
          bottom: 10.sp,
        ),
        child: SvgPicture.asset(
          'assets/images/paste.svg', // الأيقونة الافتراضية
          width: 18.sp,
          height: 18.sp,
          // colorFilter: ColorFilter.mode(Color(0xFF7A7A7A), BlendMode.srcIn),
        ),
      ),
      readonly: true,
      suffixIcon: GestureDetector(
        onTap: () {
          viewModel.pickCVFile();
        },
        child: Padding(
          padding: EdgeInsets.only(
            top: 10.sp,
            left: 5.sp,
            right: 5.sp,
            bottom: 10.sp,
          ),
          child: SvgPicture.asset(
            'assets/images/cloud-upload.svg', // الأيقونة الافتراضية
            width: 18.sp,
            height: 18.sp,
            // colorFilter: ColorFilter.mode(Color(0xFF7A7A7A), BlendMode.srcIn),
          ),
        ),
      ),
    );
  }


  Widget _buildEmploymentStatusDropdown(AlumniRegisterCubit viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        GestureDetector(
          onTap: () {
            setState(() {
              viewModel.showDropdown = !viewModel.showDropdown;
            });
          },
          child: AbsorbPointer(
            child: buildTextField(
              hint: 'حالة الوظيفة',
              controller: viewModel.employmentStatusController,
              readonly: true,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    viewModel.showDropdown = !viewModel.showDropdown;
                  });
                },
                child: Icon(
                  viewModel.showDropdown
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down, // تغيير الأيقونة
                  size: 35.sp,
                  color: MyColors.primaryColor,
                ),
              ),
              validator: (text) {
                if (text == null || text.isEmpty || text.trim().isEmpty) {
                  return 'برجاء اختيار حالة التوظيف';
                }
                return null;
              },
              prefixIcon: Padding(
                padding: EdgeInsets.only(
                  top: 10.sp,
                  left: 6.sp,
                  right: 6.sp,
                  bottom: 10.sp,
                ),
                child: SvgPicture.asset(
                  viewModel.employmentIcons[viewModel.selectedEmploymentStatus] ??
                      'assets/images/user.svg', // الأيقونة الافتراضية
                  // width: 18.sp,
                  // height: 18.sp,
                  colorFilter: ColorFilter.mode(
                    MyColors.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ),

        // القائمة المنسدلة
        if (viewModel.showDropdown)
          Column(
            children:
            viewModel.employmentIcons.entries.map((entry) {
              String status = entry.key;
              String iconPath = entry.value;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    viewModel.selectedEmploymentStatus = status;
                    viewModel.employmentStatusController.text = status; // تحديث النص داخل `TextEditingController`
                    viewModel.showDropdown = false;
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
                      SvgPicture.asset(
                        iconPath,
                        width: 18.sp,
                        height: 18.sp,
                        colorFilter: ColorFilter.mode(
                          MyColors.greyColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Text(
                        status,
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

  Widget _buildDropdown(AlumniRegisterCubit viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // الحقل الرئيسي
        GestureDetector(
          onTap: () {
            setState(() {
              viewModel.showDropdownlocation = !viewModel.showDropdownlocation;
            });
          },
          child: AbsorbPointer(
            child: buildTextField(
              hint: 'محل الشركة',
              controller: viewModel.companyLocationController,
              readonly: true,
              suffixIcon: Icon(
                viewModel.showDropdownlocation
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down, // تغيير الأيقونة
                size: 35.sp,
                color: MyColors.primaryColor,
              ),
              validator: (text) {
                if (text == null || text.isEmpty || text.trim().isEmpty) {
                  return 'برجاء اختيار محل الشركة';
                }
                return null;
              },
              prefixIcon: Padding(
                padding: EdgeInsets.all(10.sp),
                child: SvgPicture.asset(
                  'assets/images/location.svg',

                  // colorFilter: ColorFilter.mode(
                  //   Color(0xFF7A7A7A),
                  //   BlendMode.srcIn,
                  // ),
                ),
              ),
            ),
          ),
        ),

        // القائمة المنسدلة
        if (viewModel.showDropdownlocation)
          Column(
            children:
            viewModel.global.map((status) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    viewModel.companyLocationController.text = status;
                    viewModel.showDropdownlocation = false;
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
                      SvgPicture.asset(
                        'assets/images/globe-alt.svg',
                        width: 18.sp,
                        height: 18.sp,
                        // colorFilter: ColorFilter.mode(
                        //   Color(0xFF7A7A7A),
                        //   BlendMode.srcIn,
                        // ),
                      ),
                      SizedBox(width: 20.w),
                      Text(
                        status,
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

