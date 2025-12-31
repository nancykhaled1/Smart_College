import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_college/View/Student/Profile/ProfileScreen.dart';
import 'package:smart_college/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Cubits/Auth/Register/AlumniRegisterViewModel.dart';
import '../../../Cubits/Auth/Register/SyudentRegisterViewModel.dart';
import '../../../Cubits/States/States.dart';
import '../../../Cubits/Students/ProfileScreenViewModel.dart';
import '../../../utils/dialog.dart';
import '../../../utils/text_field.dart';

class MyProfileScreen extends StatefulWidget {
  static const String routeName = 'myProfile';

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  void initState() {
    super.initState();

    context.read<ProfileViewModel>().getProfile();
    context.read<RegisterCubit>().getLevels();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.backgroundColor,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            SvgPicture.asset(
              'assets/images/Background.svg',
             // width: double.infinity,
              fit: BoxFit.fill, // ✅ علشان الخلفية تفضل مليا الشاشة
            ),            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await Navigator.of(context).pushReplacement(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        ProfileScreen(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(10.r),
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
                        SizedBox(width: 20.w),
                        Text(
                          'الملف الشخصى',
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
                      listener: (context, States state) {
                        if (state is UpdateProfileSuccessState) {
                          showOverlayMessage(
                            context,
                            'تم حفظ البيانات',
                            isError: false,
                          );
                        }
                      },
                      child: BlocBuilder<ProfileViewModel, States>(
                        builder: (context, state) {
                          final viewModel = context.read<ProfileViewModel>();

                          if (state is LoadingState) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: MyColors.primaryColor,
                              ),
                            );
                          }

                          if (state is ErrorState) {
                            return Center(
                              child: Text(state.errorMessage ?? "حدث خطأ"),
                            );
                          }
                          return Stack(
                            clipBehavior:
                                Clip.none, // 👈 ده مهم جدًا عشان الصورة تطلع برا
                            children: [
                              Container(
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
                                  padding: EdgeInsets.symmetric(
                                    vertical: 20.h,
                                    horizontal: 15.w,
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10.h,
                                      ), // 👈 علشان ما يدخلش النص في الصورة
                                      Form(
                                        key: viewModel.formKey,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'الاسم',
                                              style: TextStyle(
                                                fontFamily: 'Noto Kufi Arabic',
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500,
                                                color: MyColors.primaryColor,
                                              ),
                                            ),
                                            SizedBox(height: 10.h),
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
                                              controller:
                                                  viewModel.userNameController,
                                              validator: (text) {
                                                if (text!.isEmpty ||
                                                    text.trim().isEmpty) {
                                                  return 'برجاء ادخال اسمك';
                                                }
                                                return null;
                                              },
                                              readonly:
                                                  !viewModel
                                                      .isNameEditable, // 👈 المقفل افتراضيًا
                                              suffixIcon: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    viewModel.isNameEditable =
                                                        !viewModel
                                                            .isNameEditable; // 👈 عند الضغط تتبدل الحالة
                                                  });
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    top: 15.sp,
                                                    left: 6.sp,
                                                    right: 6.sp,
                                                    bottom: 15.sp,
                                                  ),
                                                  child: SvgPicture.asset(
                                                    'assets/images/edit.svg',
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 20.h),
                                            Text(
                                              'البريد الالكترونى',
                                              style: TextStyle(
                                                fontFamily: 'Noto Kufi Arabic',
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500,
                                                color: MyColors.primaryColor,
                                              ),
                                            ),
                                            SizedBox(height: 10.h),
                                            buildTextField(
                                              keyboardType:
                                                  TextInputType.emailAddress,
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
                                                ),
                                              ),
                                              controller:
                                                  viewModel.emailController,
                                              validator: (text) {
                                                if (text!.isEmpty ||
                                                    text.trim().isEmpty) {
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
                                              readonly:
                                                  !viewModel
                                                      .isNameEditable, // 👈 المقفل افتراضيًا
                                              suffixIcon: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    viewModel.isNameEditable =
                                                        !viewModel
                                                            .isNameEditable; // 👈 عند الضغط تتبدل الحالة
                                                  });
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    top: 15.sp,
                                                    left: 6.sp,
                                                    right: 6.sp,
                                                    bottom: 15.sp,
                                                  ),
                                                  child: SvgPicture.asset(
                                                    'assets/images/edit.svg',
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 20.h),

                                          if (viewModel.userRole ==
                                          "Student") ...[
                                            Text(
                                              'السنة الدراسية',
                                              style: TextStyle(
                                                fontFamily: 'Noto Kufi Arabic',
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500,
                                                color: MyColors.primaryColor,
                                              ),
                                            ),
                                            SizedBox(height: 10.h),
                                            buildLevelDropdown(viewModel),
                                            SizedBox(height: 20.h),
                                            Text(
                                              'القسم',
                                              style: TextStyle(
                                                fontFamily: 'Noto Kufi Arabic',
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500,
                                                color: MyColors.primaryColor,
                                              ),
                                            ),
                                            SizedBox(height: 10.h),
                                            buildDepartmentDropdown(viewModel),
                                          ],

                                           // SizedBox(height: 20.h),
                                            // 🧩 لو المستخدم خريج (Graduated)
                                            if (viewModel.userRole ==
                                                "Graduated") ...[
                                              _buildResumeUploadField(
                                                viewModel,
                                              ),
                                              SizedBox(height: 20.h),
                                              _buildEmploymentStatusDropdown(
                                                viewModel,
                                              ),
                                              SizedBox(height: 20.h),
                                              if (viewModel
                                                      .selectedEmploymentStatus ==
                                                  "موظف") ...[
                                                buildTextField(
                                                  keyboardType:
                                                      TextInputType.text,
                                                  hint: 'اسم الوظيفة',
                                                  prefixIcon: Padding(
                                                    padding: EdgeInsets.all(
                                                      10.sp,
                                                    ),
                                                    child: SvgPicture.asset(
                                                      'assets/images/first-aid.svg', // الأيقونة الافتراضية
                                                      // colorFilter: ColorFilter.mode(
                                                      //   MyColors.greyColor,
                                                      //   BlendMode.srcIn,
                                                      // ),
                                                    ),
                                                  ),
                                                  controller:
                                                      viewModel
                                                          .jobTitleController,
                                                  validator: (text) {
                                                    if (text!.isEmpty ||
                                                        text.trim().isEmpty) {
                                                      return 'برجاء ادخال اسم الوظيفة';
                                                    }
                                                    return null;
                                                  },
                                                  readonly:
                                                  !viewModel
                                                      .isNameEditable, // 👈 المقفل افتراضيًا
                                                  suffixIcon: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        viewModel.isNameEditable =
                                                        !viewModel
                                                            .isNameEditable; // 👈 عند الضغط تتبدل الحالة
                                                      });
                                                    },
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                        top: 15.sp,
                                                        left: 6.sp,
                                                        right: 6.sp,
                                                        bottom: 15.sp,
                                                      ),
                                                      child: SvgPicture.asset(
                                                        'assets/images/edit.svg',
                                                      ),
                                                    ),
                                                  ),

                                                ),
                                                SizedBox(height: 20.h),
                                                _buildDropdown(viewModel),
                                                SizedBox(height: 20.h),
                                                buildTextField(
                                                  keyboardType:
                                                      TextInputType.text,
                                                  hint: 'رابط الشركة',
                                                  prefixIcon: Padding(
                                                    padding: EdgeInsets.all(
                                                      10.sp,
                                                    ),
                                                    child: SvgPicture.asset(
                                                      'assets/images/link.svg', // الأيقونة الافتراضية
                                                      // colorFilter: ColorFilter.mode(
                                                      //   Color(0xFF7A7A7A),
                                                      //   BlendMode.srcIn,
                                                      // ),
                                                    ),
                                                  ),
                                                  controller:
                                                      viewModel
                                                          .companyLinkController,
                                                  validator: (text) {
                                                    if (text!.isEmpty ||
                                                        text.trim().isEmpty) {
                                                      return 'برجاءادخال رابط الشركة';
                                                    }
                                                    return null;
                                                  },
                                                  readonly:
                                                  !viewModel
                                                      .isNameEditable, // 👈 المقفل افتراضيًا
                                                  suffixIcon: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        viewModel.isNameEditable =
                                                        !viewModel
                                                            .isNameEditable; // 👈 عند الضغط تتبدل الحالة
                                                      });
                                                    },
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                        top: 15.sp,
                                                        left: 6.sp,
                                                        right: 6.sp,
                                                        bottom: 15.sp,
                                                      ),
                                                      child: SvgPicture.asset(
                                                        'assets/images/edit.svg',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ],
                                            SizedBox(height: 40.h),

                                            ElevatedButton(
                                              onPressed:
                                                  state is LoadingState
                                                      ? null // منع الضغط أثناء التحميل
                                                      : () async {
                                                        viewModel
                                                            .updateProfile();
                                                      },
                                              child:
                                                  state is LoadingState
                                                      ? SizedBox(
                                                        width: 20.w,
                                                        height: 20.w,
                                                        child: CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                Color
                                                              >(
                                                                MyColors
                                                                    .whiteColor,
                                                              ),
                                                        ),
                                                      )
                                                      : Text(
                                                        "حفظ",
                                                        style: TextStyle(
                                                          fontSize: 15.sp,
                                                          fontFamily:
                                                              "Noto Kufi Arabic",
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    MyColors.primaryColor,
                                                foregroundColor:
                                                    MyColors.whiteColor,
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 10.h,
                                                  horizontal: 130.w,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        10.r,
                                                      ),
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

                              /// 🧍‍♀️ الصورة تطلع فوق الكونتينر
                              Positioned(
                                top: -65.h,
                                left: 0,
                                right: 0,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  alignment: Alignment.center,
                                  children: [
                                    // 🟢 الدائرة مع الخلفية المخصصة
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: MyColors.primaryColor
                                            .withOpacity(
                                              0.15,
                                            ), // 🎨 لون الخلفية الافتراضي
                                        boxShadow: [
                                          BoxShadow(
                                            color: MyColors.greyColor,
                                            blurRadius: 4,
                                            spreadRadius: 0,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: BlocBuilder<
                                        ProfileViewModel,
                                        States
                                      >(
                                        builder: (context, state) {
                                          final viewModel =
                                              context.watch<ProfileViewModel>();

                                          // 📸 لو الصورة لسه بتتحمل أو المستخدم اختار صورة
                                          if (state is LoadingState &&
                                              state.loadingMessage!.contains(
                                                "رفع الصورة",
                                              )) {
                                            return SizedBox(
                                              width: 100.w,
                                              height: 100.h,
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                      color:
                                                          MyColors.primaryColor,
                                                      strokeWidth: 3,
                                                    ),
                                              ),
                                            );
                                          }

                                          // 📸 الصورة العادية
                                          return CircleAvatar(
                                            radius: 50.r,
                                            backgroundColor:
                                                MyColors.whiteColor,
                                            child: ClipOval(
                                              child:
                                                  viewModel.image != null
                                                      ? Image.file(
                                                        viewModel.image!,
                                                        width: 100.w,
                                                        height: 100.h,
                                                        fit: BoxFit.cover,
                                                      )
                                                      : viewModel.profileImageUrl !=
                                                              null &&
                                                          viewModel
                                                              .profileImageUrl!
                                                              .startsWith(
                                                                'http',
                                                              )
                                                      ? Image.network(
                                                        viewModel
                                                            .profileImageUrl!,
                                                        width: 100.w,
                                                        height: 100.h,
                                                        fit: BoxFit.cover,
                                                    key: UniqueKey(),
                                                        loadingBuilder: (
                                                          context,
                                                          child,
                                                          loadingProgress,
                                                        ) {
                                                          if (loadingProgress ==
                                                              null)
                                                            return child;
                                                          return const Center(
                                                            child: CircularProgressIndicator(
                                                              color:
                                                                  MyColors
                                                                      .primaryColor,
                                                            ),
                                                          );
                                                        },
                                                        errorBuilder:
                                                            (
                                                              context,
                                                              error,
                                                              stackTrace,
                                                            ) => Image.asset(
                                                              'assets/images/Ellipse.png',
                                                              fit: BoxFit.cover,
                                                            ),
                                                      )
                                                      : Image.asset(
                                                        viewModel
                                                                .profileImageUrl ??
                                                            'assets/images/Ellipse.png',
                                                        // width: 120.w,
                                                        // height: 120.h,
                                                        fit: BoxFit.cover,
                                                      ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),

                                    // ✏️ زر التعديل
                                    Positioned(
                                      bottom: -5.h,
                                      right:
                                          MediaQuery.of(context).size.width /
                                              2 -
                                          55.w, // وسط الصورة تقريبا
                                      child: GestureDetector(
                                        onTap: () {
                                          context
                                              .read<ProfileViewModel>()
                                              .pickProfileImage();
                                        },
                                        child: Container(
                                          height: 25.h,
                                          width: 25.w,
                                          decoration: const BoxDecoration(
                                            color: MyColors.primaryColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: SvgPicture.asset(
                                              'assets/images/edit.svg',
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                    Colors.white,
                                                    BlendMode.srcIn,
                                                  ),
                                              width: 14.sp,
                                              height: 14.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLevelDropdown(ProfileViewModel viewModel) {
    final registerCubit = context.watch<RegisterCubit>();

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
              prefixIcon: Padding(
                padding: EdgeInsets.all(14),
                child: SvgPicture.asset(
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
                registerCubit.levelsList.map((status) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        viewModel.levelController.text =
                            status.levelNumber.toString();
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
                            status.levelNumber.toString(),
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

  Widget buildDepartmentDropdown(ProfileViewModel viewModel) {
    final registerCubit = context.watch<RegisterCubit>();

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
                child: SvgPicture.asset('assets/images/book-open.svg'),
              ),
            ),
          ),
        ),

        // القائمة المنسدلة
        if (viewModel.showDropdowndepartment)
          Column(
            children:
            registerCubit.department.map((status) {
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

  Widget _buildResumeUploadField(ProfileViewModel viewModel) {
    return buildTextField(
      hint: 'السيرة الذاتية',
      controller: viewModel.cvController,
      // validator: (text) {
      //   if (viewModel.resumeFile == null) {
      //     return 'يرجى تحميل السيرة الذاتية';
      //   }
      //   return null;
      // },

      prefixIcon: GestureDetector(
        onTap: () async {
          final url = viewModel.cvUrl;
          if (url != null && url.isNotEmpty) {
            // افتحي اللينك في المتصفح الخارجي
            if (await canLaunchUrl(Uri.parse(url))) {
              await launchUrl(
                  Uri.parse(url), mode: LaunchMode.externalApplication);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تعذر فتح الملف')),
              );
            }
          }
        },
        child: Padding(
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
      ), validator: (String ) {  },
    );
  }

  Widget _buildEmploymentStatusDropdown(ProfileViewModel viewModel) {
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
                  viewModel.employmentIcons[viewModel
                          .selectedEmploymentStatus] ??
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
                        viewModel.employmentStatusController.text =
                            status; // تحديث النص داخل `TextEditingController`
                        viewModel.showDropdown = false;
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

  Widget _buildDropdown(ProfileViewModel viewModel) {
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
                        border: Border.symmetric(
                          horizontal: BorderSide(color: MyColors.softGreyColor),
                        ),
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
