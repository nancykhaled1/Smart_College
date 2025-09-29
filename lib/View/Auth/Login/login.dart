import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_college/Cubits/States/States.dart';
import 'package:smart_college/Cubits/Auth/Login/loginScreenViewModel.dart';
import 'package:smart_college/View/Auth/Register/studentRegister.dart';
import 'package:smart_college/View/Graduated/home/graduatedHomeScreen.dart';
import 'package:smart_college/utils/colors.dart';
import 'package:smart_college/utils/text_field.dart';
import '../../../Cubits/Auth/Login/GoogleViewModel.dart';
import '../../../Cubits/Home/ChatScreenViewModel.dart';
import '../../../services/local/sharedPreference.dart';
import '../../../utils/dialog.dart';
import '../../Onboarding/onboarding.dart';
import '../../Student/Home/StudentHomeScreen.dart';
import '../../Student/studentHomeScreen.dart';
import '../../home/homeScreen.dart';
import 'forget_pass.dart';

class LoginScreen extends StatefulWidget{
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginScreenCubit,States>(
      listener: (context, state) async {
        if (state is ErrorState) {
          showOverlayMessage(context, state.errorMessage!, isError: true);

        }
        else if (state is LoginSuccessState) {
          showOverlayMessage(
              context, state.response.data!.message!, isError: false);
          final id = await TokenStorage.getUserId();

         // context.read<SendMessageCubit>().connectSocket();

          final role = await TokenStorage.getRole();
          if (role == "Student") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen()),
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
          final viewModel = context.read<LoginScreenCubit>();
          return SafeArea(
            child: WillPopScope(
              onWillPop: () async {
                // هنا بتتحكمى هل ترجعى ولا لا
                return false; // ❌ مش هيرجع
                // return true;  ✅ هيرجع
              },
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
                        Text('قم بتسجيل الدخول لحسابك',
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
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
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
                              SizedBox(height: 30.h),
                              buildTextField(
                                keyboardType: TextInputType.text,
                                hint: 'كلمة المرور',
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(
                                    top: 18.sp,
                                    left: 6.sp,
                                    right: 6.sp,
                                    bottom: 18.sp,
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/images/lock.svg',
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
                              //  SizedBox(height: 5.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: viewModel.isChecked,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            viewModel.isChecked = value!;
                                          });
                                        },
                                        activeColor: MyColors.primaryColor,
                                        side: BorderSide(color: MyColors.primaryColor),
                                      ),
                                      Text(
                                        'تذكرني',
                                        style: TextStyle(
                                          color: MyColors.greyColor,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Noto Kufi Arabic",
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation, secondaryAnimation) => ForgetPassScreen(),
                                          transitionDuration: Duration.zero,
                                          reverseTransitionDuration: Duration.zero,
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'نسيت كلمة المرور؟',
                                      style: TextStyle(
                                        color: MyColors.primaryColor,
                                        fontSize: 10.sp,
                                        fontFamily: "Noto Kufi Arabic",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 40.h),
                              ElevatedButton(
                                onPressed: state is LoadingState
                                    ? null // منع الضغط أثناء التحميل
                                    : () async {
                                  viewModel.login();
                                  // final savedToken = await TokenStorage.getToken();
                                  // print("Saved Token: $savedToken");

                                },
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
                                child: state is LoadingState
                                    ? SizedBox(
                                  width: 20.w,
                                  height: 20.w,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(MyColors.whiteColor),
                                  ),
                                )
                                    :  Text(
                                  "تسجيل الدخول",
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontFamily: "Noto Kufi Arabic",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('ليس لديك حساب؟',
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
                                StudentRegisterScreen.routeName,
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
                          listener: (context, state)  async {
                            if (state is LoadingState) {
                              showOverlayMessage(context, "جارى التحميل", isError: false);
                            } else if (state is ErrorState) {
                              showOverlayMessage(context, state.errorMessage!, isError: true);
                            } else if (state is GoogleSuccessState) {
                              showOverlayMessage(
                                  context, "تم التسجيل بنجاح", isError: false);
                              final role = await TokenStorage.getRole();
                              if (role == "Student") {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => HomeScreen()),
                                );
                              } else if (role == "Graduated") {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => GraduatedHomeScreen()),
                                );
                              } else {
                                // default fallback
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => OnBoarding()),
                                );
                              }
                            }
                          },
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: state is LoadingState
                                  ? null
                                  : () async {
                                //final prefs = await SharedPreferences.getInstance();
                                final role =  await TokenStorage.getRole();
                                context.read<GoogleCubit>().signInWithGoogle(
                                   role: role ?? ''
                                );
                              },
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
}