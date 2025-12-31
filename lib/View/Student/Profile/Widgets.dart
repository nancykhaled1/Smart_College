// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:smart_college/utils/colors.dart';
// import 'package:smart_college/Cubits/Students/ProfileScreenViewModel.dart';
//
// import '../../../Cubits/Auth/Register/SyudentRegisterViewModel.dart';
// import '../../../utils/text_field.dart';
//
// // ✅ هذا الملف يحتوي على جميع الودجتس الخاصة بالدروب داون والـ CV upload في شاشة البروفايل
//
// //------------------------------------------------------------------------------
// //  السنة الدراسية
// //------------------------------------------------------------------------------
// Widget buildLevelDropdown(BuildContext context, ProfileViewModel viewModel) {
//   final registerCubit = context.watch<RegisterCubit>();
//
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       GestureDetector(
//         onTap: () {
//           viewModel.showDropdownlevel = !viewModel.showDropdownlevel;
//         },
//         child: AbsorbPointer(
//           child: buildTextField(
//             hint: 'السنة الدراسيه',
//             controller: viewModel.levelController,
//             readonly: true,
//             suffixIcon: Icon(
//               viewModel.showDropdownlevel
//                   ? Icons.arrow_drop_up
//                   : Icons.arrow_drop_down,
//               size: 35.sp,
//               color: MyColors.primaryColor,
//             ),
//             validator: (text) {
//               if (text == null || text.isEmpty) {
//                 return 'برجاء اختيار السنه الدراسيه';
//               }
//               return null;
//             },
//             prefixIcon: Padding(
//               padding: EdgeInsets.all(14),
//               child: SvgPicture.asset(
//                 'assets/images/level.svg',
//                 width: 10.sp,
//                 height: 10.sp,
//               ),
//             ),
//           ),
//         ),
//       ),
//
//       if (viewModel.showDropdownlevel)
//         Column(
//           children: registerCubit.levelsList.map((status) {
//             return GestureDetector(
//               onTap: () {
//                 viewModel.levelController.text =
//                     status.levelNumber.toString();
//                 viewModel.showDropdownlevel = false;
//               },
//               child: Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(15),
//                 decoration: BoxDecoration(
//                   border: Border.symmetric(
//                     horizontal: BorderSide(color: MyColors.softGreyColor),
//                   ),
//                   color: MyColors.softWhiteColor,
//                 ),
//                 child: Row(
//                   children: [
//                     SvgPicture.asset(
//                       'assets/images/level.svg',
//                       width: 15.sp,
//                       height: 15.sp,
//                       colorFilter: ColorFilter.mode(
//                         Color(0xFF7A7A7A),
//                         BlendMode.srcIn,
//                       ),
//                     ),
//                     SizedBox(width: 20.w),
//                     Text(
//                       status.levelNumber.toString(),
//                       style: TextStyle(
//                         color: MyColors.greyColor,
//                         fontFamily: "Noto Kufi Arabic",
//                         fontWeight: FontWeight.w400,
//                         fontSize: 12.sp,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//     ],
//   );
// }
//
// //------------------------------------------------------------------------------
// //  القسم
// //------------------------------------------------------------------------------
// Widget buildDepartmentDropdown(BuildContext context, ProfileViewModel viewModel) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       GestureDetector(
//         onTap: () {
//           viewModel.showDropdowndepartment =
//           !viewModel.showDropdowndepartment;
//         },
//         child: AbsorbPointer(
//           child: buildTextField(
//             hint: 'القسم',
//             controller: viewModel.departmentController,
//             readonly: true,
//             suffixIcon: Icon(
//               viewModel.showDropdowndepartment
//                   ? Icons.arrow_drop_up
//                   : Icons.arrow_drop_down,
//               size: 35.sp,
//               color: MyColors.primaryColor,
//             ),
//             validator: (text) {
//               if (text == null || text.isEmpty) {
//                 return 'برجاء اختيار القسم';
//               }
//               return null;
//             },
//             prefixIcon: Padding(
//               padding: EdgeInsets.all(10.sp),
//               child: SvgPicture.asset('assets/images/book-open.svg'),
//             ),
//           ),
//         ),
//       ),
//
//       if (viewModel.showDropdowndepartment)
//         Column(
//           children: viewModel.department.map((status) {
//             return GestureDetector(
//               onTap: () {
//                 viewModel.departmentController.text = status;
//                 viewModel.showDropdowndepartment = false;
//               },
//               child: Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(15),
//                 decoration: BoxDecoration(
//                   border: Border.symmetric(
//                     horizontal: BorderSide(color: MyColors.softGreyColor),
//                   ),
//                   color: MyColors.softWhiteColor,
//                 ),
//                 child: Row(
//                   children: [
//                     SvgPicture.asset(
//                       'assets/images/book-open.svg',
//                       width: 18.sp,
//                       height: 18.sp,
//                       colorFilter: ColorFilter.mode(
//                         Color(0xFF7A7A7A),
//                         BlendMode.srcIn,
//                       ),
//                     ),
//                     SizedBox(width: 20.w),
//                     Text(
//                       status,
//                       style: TextStyle(
//                         color: MyColors.greyColor,
//                         fontFamily: "Noto Kufi Arabic",
//                         fontWeight: FontWeight.w400,
//                         fontSize: 12.sp,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//     ],
//   );
// }
//
// //------------------------------------------------------------------------------
// //  تحميل السيرة الذاتية
// //------------------------------------------------------------------------------
// Widget buildResumeUploadField(ProfileViewModel viewModel) {
//   return buildTextField(
//     hint: 'السيرة الذاتية',
//     controller: viewModel.cvController,
//     prefixIcon: Padding(
//       padding: EdgeInsets.all(10.sp),
//       child: SvgPicture.asset('assets/images/paste.svg'),
//     ),
//     readonly: true,
//     suffixIcon: GestureDetector(
//       onTap: () {
//         viewModel.pickCVFile();
//       },
//       child: Padding(
//         padding: EdgeInsets.all(10.sp),
//         child: SvgPicture.asset('assets/images/cloud-upload.svg'),
//       ),
//     ),
//     validator: (text) => null,
//   );
// }
//
// //------------------------------------------------------------------------------
// //  حالة التوظيف
// //------------------------------------------------------------------------------
// Widget buildEmploymentStatusDropdown(
//     BuildContext context, ProfileViewModel viewModel) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       GestureDetector(
//         onTap: () {
//           viewModel.showDropdown = !viewModel.showDropdown;
//         },
//         child: AbsorbPointer(
//           child: buildTextField(
//             hint: 'حالة الوظيفة',
//             controller: viewModel.employmentStatusController,
//             readonly: true,
//             suffixIcon: Icon(
//               viewModel.showDropdown
//                   ? Icons.arrow_drop_up
//                   : Icons.arrow_drop_down,
//               size: 35.sp,
//               color: MyColors.primaryColor,
//             ),
//             validator: (text) {
//               if (text == null || text.isEmpty) {
//                 return 'برجاء اختيار حالة التوظيف';
//               }
//               return null;
//             },
//             prefixIcon: Padding(
//               padding: EdgeInsets.all(10.sp),
//               child: SvgPicture.asset(
//                 viewModel.employmentIcons[
//                 viewModel.selectedEmploymentStatus] ??
//                     'assets/images/user.svg',
//                 colorFilter: ColorFilter.mode(
//                   MyColors.primaryColor,
//                   BlendMode.srcIn,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//
//       if (viewModel.showDropdown)
//         Column(
//           children: viewModel.employmentIcons.entries.map((entry) {
//             String status = entry.key;
//             String iconPath = entry.value;
//
//             return GestureDetector(
//               onTap: () {
//                 viewModel.selectedEmploymentStatus = status;
//                 viewModel.employmentStatusController.text = status;
//                 viewModel.showDropdown = false;
//               },
//               child: Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(15),
//                 decoration: BoxDecoration(
//                   border: Border.symmetric(
//                     horizontal: BorderSide(color: MyColors.softGreyColor),
//                   ),
//                   color: MyColors.softWhiteColor,
//                 ),
//                 child: Row(
//                   children: [
//                     SvgPicture.asset(
//                       iconPath,
//                       width: 18.sp,
//                       height: 18.sp,
//                       colorFilter: ColorFilter.mode(
//                         MyColors.greyColor,
//                         BlendMode.srcIn,
//                       ),
//                     ),
//                     SizedBox(width: 20.w),
//                     Text(
//                       status,
//                       style: TextStyle(
//                         color: MyColors.greyColor,
//                         fontFamily: "Noto Kufi Arabic",
//                         fontWeight: FontWeight.w400,
//                         fontSize: 12.sp,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//     ],
//   );
// }
//
// //------------------------------------------------------------------------------
// //  مكان الشركة
// //------------------------------------------------------------------------------
// Widget buildCompanyLocationDropdown(ProfileViewModel viewModel) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       GestureDetector(
//         onTap: () {
//           viewModel.showDropdownlocation = !viewModel.showDropdownlocation;
//         },
//         child: AbsorbPointer(
//           child: buildTextField(
//             hint: 'محل الشركة',
//             controller: viewModel.companyLocationController,
//             readonly: true,
//             suffixIcon: Icon(
//               viewModel.showDropdownlocation
//                   ? Icons.arrow_drop_up
//                   : Icons.arrow_drop_down,
//               size: 35.sp,
//               color: MyColors.primaryColor,
//             ),
//             validator: (text) {
//               if (text == null || text.isEmpty) {
//                 return 'برجاء اختيار محل الشركة';
//               }
//               return null;
//             },
//             prefixIcon: Padding(
//               padding: EdgeInsets.all(10.sp),
//               child: SvgPicture.asset('assets/images/location.svg'),
//             ),
//           ),
//         ),
//       ),
//
//       if (viewModel.showDropdownlocation)
//         Column(
//           children: viewModel.global.map((status) {
//             return GestureDetector(
//               onTap: () {
//                 viewModel.companyLocationController.text = status;
//                 viewModel.showDropdownlocation = false;
//               },
//               child: Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(15),
//                 decoration: BoxDecoration(
//                   border: Border.symmetric(
//                     horizontal: BorderSide(color: MyColors.softGreyColor),
//                   ),
//                   color: MyColors.softWhiteColor,
//                 ),
//                 child: Row(
//                   children: [
//                     SvgPicture.asset(
//                       'assets/images/globe-alt.svg',
//                       width: 18.sp,
//                       height: 18.sp,
//                     ),
//                     SizedBox(width: 20.w),
//                     Text(
//                       status,
//                       style: TextStyle(
//                         color: MyColors.greyColor,
//                         fontFamily: "Noto Kufi Arabic",
//                         fontWeight: FontWeight.w400,
//                         fontSize: 12.sp,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//     ],
//   );
// }
