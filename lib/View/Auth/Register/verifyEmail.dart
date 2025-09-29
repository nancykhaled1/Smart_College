import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_college/View/home/homeScreen.dart';
import 'package:smart_college/utils/colors.dart';
import '../../../Cubits/Auth/Register/States.dart';
import '../../../Cubits/Auth/Register/VerifyemailViewModel.dart';
import '../../../services/local/sharedPreference.dart';
import '../../../utils/dialog.dart';
import '../../Graduated/home/graduatedHomeScreen.dart';
import '../../Onboarding/onboarding.dart';
import '../../Student/Home/StudentHomeScreen.dart';


class VerifyEmail extends StatefulWidget {
  static const String routeName = 'code';
  final String userId; // 👈 هنا هيجيلك من صفحة الريجيستر

  const VerifyEmail({Key? key, required this.userId}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<VerifyEmailCubit>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.whiteColor,
        body: Padding(
          padding: EdgeInsets.only(right: 15.sp, left: 15.sp, top: 50.sp),
          child: BlocConsumer<VerifyEmailCubit, RegisterStates>(
            listener: (context, state) async {
              if (state is VerifyEmailSuccessState) {
                showOverlayMessage(context, state.response.message!, isError: false);

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
              } else if (state is RegisterErrorState) {
                showOverlayMessage(context, state.errorMessage!, isError: true);
              }

            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: WillPopScope(
                  onWillPop: () async {
                    // هنا بتتحكمى هل ترجعى ولا لا
                    return false; // ❌ مش هيرجع
                    // return true;  ✅ هيرجع
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: SvgPicture.asset('assets/images/code-pass.svg')),
                      SizedBox(height: 50.h),
                      Text(
                        'ارجع الي البريد الالكتروني الخاص بك!',
                        style: TextStyle(
                          color: MyColors.softBlackColor,
                          fontSize: 20.sp,
                          fontFamily: "Noto Kufi Arabic",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'تم ارسال كود مكون من 6 ارقام الي بريدك الالكتروني قم بادخال الكود',
                        style: TextStyle(
                          color: MyColors.greyColor,
                          fontSize: 14.sp,
                          fontFamily: "Noto Kufi Arabic",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 40.h),

                      /// Input Fields
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(6, (index) {
                          return Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: SizedBox(
                              width: 50.w,
                              height: 50.h,
                              child: TextField(
                                controller: viewModel.controllers[index],
                                focusNode: viewModel.focusNodes[index],
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color: MyColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  counterText: "",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: viewModel.controllers[index].text.isNotEmpty
                                          ? MyColors.primaryColor
                                          : MyColors.softGreyColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: MyColors.primaryColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    if (index < 5) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  } else {
                                    if (index > 0) {
                                      FocusScope.of(context).previousFocus();
                                    }
                                  }
                                  viewModel.checkCodeCompletion();
                                },
                              ),
                            ),
                          );
                        }),
                      ),

                      SizedBox(height: 70.h),

                      /// Verify Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: (state is! RegisterLoadingState && viewModel.isCodeComplete)
                              ? () {
                            final code = viewModel.getEnteredCode();
                            viewModel.verifyEmail(userId: widget.userId, code: code);


                          }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: viewModel.isCodeComplete
                                ? MyColors.primaryColor
                                : MyColors.softGreenColor,
                            foregroundColor: MyColors.whiteColor,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: (state is RegisterLoadingState)
                              ? SizedBox(
                            width: 24.w,
                            height: 24.h,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                              : Text(
                            "ارسال الكود",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: "Noto Kufi Arabic",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
