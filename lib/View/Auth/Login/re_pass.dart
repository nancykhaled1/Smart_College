import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_college/View/Auth/Login/login.dart';
import 'package:smart_college/utils/success.dart';

import '../../../Cubits/Auth/Login/States.dart';
import '../../../Cubits/Auth/Login/forget_passViewModel.dart';
import '../../../Cubits/Auth/Login/re-passViewModel.dart';
import '../../../utils/colors.dart';
import '../../../utils/dialog.dart';
import '../../../utils/text_field.dart';

class RePassword extends StatefulWidget{
  static const String routeName = 'repass';
  final String email;
  final String code;

  const RePassword({
    Key? key,
    required this.email,
    required this.code,
  }) : super(key: key);

  @override
  State<RePassword> createState() => _RePasswordState();
}

class _RePasswordState extends State<RePassword> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RePasswordCubit,LoginStates>(
      listener: (context, state) {
        if (state is LoginErrorState) {
          showOverlayMessage(context, state.errorMessage!, isError: true);

        } else if (state is ChangePassSuccessState) {
          showOverlayMessage(context, state.response.data!.message!, isError: false);
          //final email = context.read<ForgetPassScreenCubit>().emailController.text;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SuccessScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        final viewModel = context.read<RePasswordCubit>();
        return SafeArea(
          child: Scaffold(
            backgroundColor: MyColors.whiteColor,
            body: Padding(
              padding: EdgeInsets.only(right : 15.sp , left: 15.sp, top: 50.sp),
              child: SingleChildScrollView(
                child: Form(
                  key: viewModel.formKey,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: SvgPicture.asset('assets/images/repassword.svg')),
                      SizedBox(
                        height: 50.h,
                      ),
                      Text(
                        'ادخال كلمة المرور الجديدة',
                        style: TextStyle(
                          color: MyColors.blackColor,
                          fontSize: 20.sp,
                          fontFamily: "Noto Kufi Arabic",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(' قم بادخال كلمة المرور الجديدة',
                        style: TextStyle(
                          color: MyColors.greyColor,
                          fontSize: 14.sp,
                          fontFamily: "Noto Kufi Arabic",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 40.h),
                      buildTextField(
                        keyboardType: TextInputType.visiblePassword,
                        hint: 'ادخل كلمة المرور',
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.sp,
                            vertical: 20.sp,
                          ),
                          child: SvgPicture.asset(
                            'assets/images/lock.svg', // الأيقونة الافتراضية
                          ),
                        ),
                        suffixIcon: Icon( viewModel.isPasswordVisible
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                          size: 18.sp,color: MyColors.primaryColor,),
                        suffixIconFunction: () {
                          setState(() {
                            viewModel.isPasswordVisible = !viewModel.isPasswordVisible;
                          });
                        },
                        controller: viewModel.passwordController,
                        validator: (text) {
                          if (text == null || text.isEmpty)
                            return 'يرجى إدخال كلمة المرور';
                          if (text.length < 6)
                            return 'يجب أن تكون كلمة المرور 6 أحرف على الأقل';
                          return null;
                        },
                        isPassword: viewModel.isPasswordVisible,
                      ),
                      SizedBox(height: 20.h),
                      buildTextField(
                        keyboardType: TextInputType.visiblePassword,
                        hint: 'ادخل تأكيد كلمة المرور',
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.sp,
                            vertical: 20.sp,
                          ),
                          child: SvgPicture.asset(
                            'assets/images/lock.svg', // الأيقونة الافتراضية
                          ),
                        ),
                        suffixIcon: Icon( viewModel.isRePasswordVisible
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                          size: 18.sp,color: MyColors.primaryColor,),
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

                        isPassword: viewModel.isRePasswordVisible,
                      ),
                      SizedBox(height: 50.h),
                      ElevatedButton(
                        onPressed: () {
                          final newPassword = viewModel.passwordController.text;

                          viewModel.changePassword(email: widget.email, code: widget.code, newPassword: newPassword);
                        },
                        child: Text(
                          "تعيين كلمة المرور",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: "Noto Kufi Arabic",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.primaryColor,
                          foregroundColor: MyColors.whiteColor,
                          padding: EdgeInsets.symmetric(
                            vertical: 10.h,
                            horizontal: 95.w,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
    }
}