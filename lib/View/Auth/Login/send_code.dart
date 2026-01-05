import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_college/Cubits/States/States.dart';
import 'package:smart_college/Cubits/Auth/Login/send_codeViewModel.dart';
import 'package:smart_college/View/Auth/Login/re_pass.dart';
import '../../../utils/colors.dart';
import '../../../utils/dialog.dart';

class SendCode extends StatefulWidget {
  static const String routeName = 'code';
  final String email;
  const SendCode({Key? key, required this.email}) : super(key: key);

  @override
  State<SendCode> createState() => _SendCodeState();
}

class _SendCodeState extends State<SendCode> {
  // String? code;



  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<SendCodeCubit>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.whiteColor,
        body: Padding(
          padding: EdgeInsets.only(right: 15.sp, left: 15.sp, top: 50.sp),
          child: BlocConsumer<SendCodeCubit, States>(
            listener: (context, state) {
              if (state is ErrorState) {
                showOverlayMessage(context, state.errorMessage!, isError: true);

              }
              if (state is ResetPassSuccessState) {
                showOverlayMessage(context, state.response.data!.message!, isError: false);
                final code = context.read<SendCodeCubit>().getEnteredCode();
                print("CODE ENTERED: $code");
               // print("✅ Entered Code: $enteredCode");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RePassword(
                      email : widget.email,
                        code : code
                    ),
                  ),
                );
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
                        'تم ارسال كود مكون من 6 ارقام الي '
                            ' ${widget.email} قم بادخال الكود',
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
                          onPressed: (state is! LoadingState && viewModel.isCodeComplete)
                              ? () {
                            final code = viewModel.getEnteredCode();
                            viewModel.resetPassword(email: widget.email, code: code);


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
                          child: (state is LoadingState)
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
