import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_college/Cubits/Auth/Register/VerifyemailViewModel.dart';
import 'package:smart_college/View/Auth/Login/login.dart';
import 'package:smart_college/View/Auth/Register/verifyEmail.dart';
import 'package:smart_college/View/Student/Home/StudentHomeScreen.dart';
import 'package:smart_college/View/home/homeScreen.dart';
import 'package:smart_college/utils/colors.dart';
import 'package:smart_college/utils/text_field.dart';
import '../../../Cubits/Auth/Login/GoogleViewModel.dart';
import '../../../Cubits/Home/ChatScreenViewModel.dart';
import '../../../Cubits/States/States.dart';
import '../../../Cubits/Auth/Register/States.dart';
import '../../../Cubits/Auth/Register/SyudentRegisterViewModel.dart';
import '../../../services/local/sharedPreference.dart';
import '../../../utils/dialog.dart';
import '../../Graduated/home/graduatedHomeScreen.dart';
import 'CompleteStudentProfile.dart';

class StudentRegisterScreen extends StatefulWidget {
  static const String routeName = 'studentRegister';
  final String role;
  const StudentRegisterScreen({super.key, required this.role});

  @override
  State<StudentRegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<StudentRegisterScreen> {
  late RegisterCubit registerCubit;

  @override
  void initState() {
    super.initState();
    registerCubit = context.read<RegisterCubit>();
    registerCubit.getLevels();
    registerCubit.getDepartment();
  }

  @override
  void dispose() {
    registerCubit.clearForm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterErrorState) {
          showOverlayMessage(context, state.errorMessage!, isError: true);

        }
        else if (state is LevelSuccessState) {
          setState(() {});
        }
        else if (state is RegisterSuccessState) {
          showOverlayMessage(
            context,
            state.response.data!.message!,
            isError: false,
          );
          final userId = state.response.data?.userId; // استبدل بالاسم المناسب
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerifyEmail(userId: userId!),
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
                    mainAxisSize: MainAxisSize.max, // ✅ ده يمنع الـ infinite height
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 50.h, bottom: 20.h),
                        child: SvgPicture.asset('assets/images/logo.svg'),
                      ),
                      Text(
                        'مرحبا بك !',
                        style: TextStyle(
                          fontSize: 24.sp,
                          color: MyColors.softBlackColor,
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
                                  top: 18.sp,
                                  left: 6.sp,
                                  right: 6.sp,
                                  bottom: 18.sp,
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
                            SizedBox(height: 20.h),
                            buildLevelDropdown(viewModel),
                            SizedBox(height: 20.h),
                            buildDepartmentDropdown(viewModel),
                            SizedBox(height: 40.h),
                            ElevatedButton(
                              onPressed:
                                  state is RegisterLoadingState
                                      ? null // منع الضغط أثناء التحميل
                                      : () {
                                        viewModel.registerStudent(
                                          role: widget.role,
                                        );
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
                      BlocConsumer<GoogleCubit, States>(
                        listener: (context, state) async {
                          if (state is LoadingState) {
                            showOverlayMessage(
                              context,
                              "جارى التحميل",
                              isError: false,
                            );
                          } else if (state is ErrorState) {
                            showOverlayMessage(
                              context,
                              state.errorMessage!,
                              isError: true,
                            );
                          } else if (state is GoogleSuccessState) {
                            showOverlayMessage(
                              context,
                              "تم التسجيل بنجاح",
                              isError: false,
                            );

                            final role = await TokenStorage.getRole();
                            final savedIsNew = await TokenStorage.getIsNew();


                            if (role == "Student") {
                              // 🟢 هنا بتشيكي هل هو اول مرة ولا لأ

                              if (savedIsNew!) {
                                // لو اول مرة → شاشة اختيار السنة + القسم
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => CompleteProfile(),
                                  ),
                                );
                              } else {
                                // مش اول مرة → دخله عالهوم
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => HomeScreen(),
                                  ),
                                );
                              }
                            } else if (role == "Graduated") {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => GraduatedHomeScreen(),
                                ),
                              );
                            }
                          }
                        },
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed:
                                state is LoadingState
                                    ? null
                                    : () async {
                                      context
                                          .read<GoogleCubit>()
                                          .signInWithGoogle(role: widget.role);
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
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildLevelDropdown(RegisterCubit viewModel) {
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
                if (text == null || text.isEmpty || text.trim().isEmpty) {
                  return 'برجاء اختيار السنه الدراسيه';
                }
                return null;
              },
              prefixIcon:
              Padding(
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

  Widget buildDepartmentDropdown(RegisterCubit viewModel) {
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
                if (text == null || text.isEmpty || text.trim().isEmpty) {
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
                        viewModel.departmentController.text = status.name ??'';
                        viewModel.showDropdowndepartment = false;
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
                            'assets/images/book-open.svg',
                            width: 18.sp,
                            height: 18.sp,
                            colorFilter: ColorFilter.mode(
                              Color(0xFF7A7A7A),
                              BlendMode.srcIn,
                            ),
                          ),
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
