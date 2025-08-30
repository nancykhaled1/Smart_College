import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_college/Cubits/Auth/Register/VerifyemailViewModel.dart';
import 'package:smart_college/View/Auth/Login/login.dart';
import 'package:smart_college/View/Auth/Register/verifyEmail.dart';
import 'package:smart_college/utils/colors.dart';
import 'package:smart_college/utils/text_field.dart';
import '../../../Cubits/Auth/Login/GoogleViewModel.dart';
import '../../../Cubits/Auth/Login/States.dart';
import '../../../Cubits/Auth/Register/States.dart';
import '../../../Cubits/Auth/Register/SyudentRegisterViewModel.dart';
import '../../../utils/dialog.dart';
import '../../Graduated/home/graduatedHomeScreen.dart';

class StudentRegisterScreen extends StatefulWidget {
  static const String routeName = 'studentRegister';
  final String role;
  const StudentRegisterScreen({super.key, required this.role});

  @override
  State<StudentRegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<StudentRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterErrorState) {
         // Navigator.pop(context); // لإغلاق الديالوج لو كان مفتوح
          showOverlayMessage(context, state.errorMessage!, isError: true);

          // ScaffoldMessenger.of(
          //   context,
          // ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        } else if (state is RegisterSuccessState) {
          showOverlayMessage(context, state.response.data!.message!, isError: false);
          final userId = state.response.data?.userId; // استبدل بالاسم المناسب
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerifyEmail(userId: userId!),
            ),
          );


          // ScaffoldMessenger.of(
          //   context,
          // ).showSnackBar( SnackBar(content: Text(state.response.data!.message!)));
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
          child: Scaffold(
            backgroundColor: MyColors.whiteColor,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 50.h, bottom: 20.h),
                      child: SvgPicture.asset('assets/images/logo.svg'),
                    ),
                    Text(
                      'مرحبا بك !',
                      style: TextStyle(
                        fontSize: 24.sp,
                        color: MyColors.blackColor,
                        fontFamily: 'Noto Kufi Arabic',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      'قم بادخال بيانتك لانشاء حسابك',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: MyColors.greyColor,
                        fontFamily: 'Noto Kufi Arabic',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 30.h),
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
                                top: 10.sp,
                                left: 6.sp,
                                right: 6.sp,
                                bottom: 10.sp,
                              ),
                              child: SvgPicture.asset(
                                'assets/images/user.svg', // الأيقونة الافتراضية
                                // width: 15.sp,
                                // height: 15.sp,
                              ),
                            ),
                            controller: viewModel.userNameController,
                            validator: (text) {
                              if (text!.isEmpty || text.trim().isEmpty) {
                                return 'برجاء ادخال اسمك';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20.h),
                          buildTextField(
                            keyboardType: TextInputType.emailAddress,
                            hint: 'البريد الالكتروني',
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(
                                top: 10.sp,
                                left: 6.sp,
                                right: 6.sp,
                                bottom: 10.sp,
                              ),
                              child: SvgPicture.asset(
                                'assets/images/mail.svg',
                                width: 10.sp,
                                height: 10.sp,
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
                                top: 20.sp,
                                left: 6.sp,
                                right: 6.sp,
                                bottom: 20.sp,
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
                                viewModel.isPasswordVisible =
                                    !viewModel.isPasswordVisible;
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
                                top: 20.sp,
                                left: 6.sp,
                                right: 6.sp,
                                bottom: 20.sp,
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
                                viewModel.isRePasswordVisible =
                                    !viewModel.isRePasswordVisible;
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
                          SizedBox(height: 40.h),
                          ElevatedButton(
                            onPressed: state is RegisterLoadingState
                                ? null // منع الضغط أثناء التحميل
                                : () {
                              viewModel.registerStudent(role: widget.role);
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
                        Text(
                          'لديك حساب بالفعل؟',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: MyColors.greyColor,
                            fontFamily: 'Noto Kufi Arabic',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              LoginScreen.routeName,
                            );
                          },
                          child: Text(
                            'سجل الان',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: MyColors.primaryColor,
                              fontSize: 12.sp,
                              color: MyColors.primaryColor,
                              fontFamily: 'Noto Kufi Arabic',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 30.h),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: MyColors.greyColor,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.0,
                          ), // مسافة يمين وشمال
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
                    SizedBox(height: 30.h),
                    BlocConsumer<GoogleCubit, LoginStates>(
                      listener: (context, state) {
                        if (state is LoginLoadingState) {
                          showOverlayMessage(context, "Loading...", isError: false);
                        } else if (state is LoginErrorState) {
                          showOverlayMessage(context, state.errorMessage!, isError: true);
                        } else if (state is GoogleSuccessState) {
                          showOverlayMessage(context, "تم التسجيل بنجاح", isError: false);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => GraduatedHomeScreen()),
                          );
                        }
                      },
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: state is LoginLoadingState
                              ? null
                              : () {
                            context.read<GoogleCubit>().signInWithGoogle();
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
            ),
          ),
        );
      },
    );
  }
}



//import 'package:flutter/material.dart';



