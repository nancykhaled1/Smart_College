import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_college/Cubits/Auth/Login/forget_passViewModel.dart';
import 'package:smart_college/View/Auth/Login/send_code.dart';
import '../../../Cubits/Auth/Login/States.dart';
import '../../../utils/colors.dart';
import '../../../utils/dialog.dart';
import '../../../utils/text_field.dart';



class ForgetPassScreen extends StatelessWidget{
  static const String routeName = 'pass';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPassScreenCubit,LoginStates>(
      listener: (context, state) {
        if (state is LoginErrorState) {
          showOverlayMessage(context, state.errorMessage!, isError: true);

        } else if (state is SendEmailSuccessState) {
          showOverlayMessage(context, state.response.data!.message!, isError: false);
          final email = context.read<ForgetPassScreenCubit>().emailController.text;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SendCode(email: email,),
            ),
          );
        }
      },
      builder: (context, state) {
        final viewModel = context.read<ForgetPassScreenCubit>();
        return SafeArea(child: Scaffold(
        backgroundColor: MyColors.whiteColor,
        body: SingleChildScrollView(
          child: Padding(
          padding: EdgeInsets.only(right : 15.sp , left: 15.sp, top: 50.sp),
          child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Center(child: SvgPicture.asset('assets/images/password.svg')),
          SizedBox(
          height: 50.h,
          ),
          Text('نسيت كلمة المرور؟',
          style: TextStyle(
          color: MyColors.blackColor,
          fontFamily: "Noto Kufi Arabic",
          fontSize: 20.sp,
          fontWeight: FontWeight.w400
          ),
          ),
          SizedBox(
          height: 20.h,
          ),
          Text(
          'قم بادخال بريدك الالكتروني لارسال عليه كود\nالتحقق',
          style: TextStyle(
          color: MyColors.greyColor,
          fontSize: 14.sp,
          fontFamily: "Noto Kufi Arabic",
          fontWeight: FontWeight.w400
          ),
          ),
          SizedBox(
          height: 20.h,
          ),
          Form(
            key: viewModel.formKey,
            child: Column(
              children: [
                Padding(
                padding: EdgeInsets.all(8.sp),
                child: buildTextField(
                keyboardType: TextInputType.emailAddress,
                hint: 'البريد الالكتروني',
                prefixIcon: Padding(
                padding:  EdgeInsets.only(top: 10.sp,left: 6.sp,right: 6.sp,bottom: 10.sp),
                child: SvgPicture.asset(
                'assets/images/mail.svg', // الأيقونة الافتراضية
                width: 15.sp,
                height: 15.sp,

                ),
                ),
                controller: viewModel.emailController,
                validator: (text) {
                if (text!.isEmpty ||
                text.trim().isEmpty) {
                return 'برجاء ادخال البريد الالكترونى';
                }
                bool emailValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(text);
                if (!emailValid) {
                return 'برجاء ادخال بريد الكتروني صحيح';
                }
                return null;
                },
                ),
                ),
              ],
            ),
          ),

          SizedBox(
          height: 30.h,
          ),
          Padding(
          padding:  EdgeInsets.all(8.sp),
          child: ElevatedButton(
            onPressed: state is LoginLoadingState
                ? null // منع الضغط أثناء التحميل
                : () {
              viewModel.sendEmail();
            },
            child: state is LoginLoadingState
                ? Center(
                  child: SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(MyColors.whiteColor),
                                ),
                              ),
                )
                :  Text(
          "انشاء حساب",
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
          horizontal: 113.w,
          ),
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
          ),
          ),
          ),
          ),
          ],
          ),
          ),
        )
        )
        );

      },

    );




  }

}