import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:smart_college/Cubits/States/States.dart';
import 'package:smart_college/Repositories/ProfileRepository.dart';
import 'package:smart_college/View/Auth/Login/login.dart';
import 'package:smart_college/View/home/accountType.dart';
import 'package:smart_college/services/local/sharedPreference.dart';
import '../../Models/Request/ImageRequest.dart';
import '../../Models/Request/UpdateProfileRequest.dart';
import '../../View/Auth/Register/roleselection.dart';
import '../Home/ChatScreenViewModel.dart';

class ProfileViewModel extends Cubit<States> {
  final ProfileRepository repository;

  ProfileViewModel(this.repository) : super(InitialState());

  var formKey = GlobalKey<FormState>();
  var profileFormKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController levelController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController languageController = TextEditingController();


  TextEditingController employmentStatusController = TextEditingController();
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController companyLocationController = TextEditingController();
  TextEditingController companyLinkController = TextEditingController();
  TextEditingController cvController = TextEditingController();


  bool showDropdownlevel = false;
  bool showDropdownLanguage = false;
  bool showDropdowndepartment = false;
  bool isChecked = false;
  bool isDarkMode = false;


  bool isNameEditable = false;
  bool isEmailEditable = false;
  bool isEditable = false;

  File? image;
  final ImagePicker _picker = ImagePicker();
  String? profileImageUrl;

  String? userRole;

  bool showField = false;
  bool showDropdown = false;
  bool showDropdownlocation = false;
  String selectedEmploymentStatus = "حالة الوظيفة";
  File? resumeFile;

  bool isGraduated = false; // ← أضفنا ده لتحديد نوع المستخدم
  String? employmentStatusValue;


  String? cvUrl; // رابط الـ CV الكامل من السيرفر
  String? cvFileName; // اسم الملف فقط




  final Map<String, String> employmentIcons = {
    "موظف": "assets/images/user-tick.svg",
    "غير موظف": "assets/images/user-cross.svg",
    "طالب دراسات عليا": "assets/images/user-shield.svg",
    "عامل حر": "assets/images/user-heart.svg",
  };

  final List<String> global = [
    "داخل مصر",
    "خارج مصر",
  ];

  String mapEmploymentStatus(String statusEn) {
    switch (statusEn) {
      case "Employed":
        return "موظف";
      case "Job Seeker":
        return "غير موظف";
      case "Freelancer":
        return "عامل حر";
      case "Postgraduate Studies":
        return "طالب دراسات عليا";
      default:
        return "غير موظف"; // الافتراضي// default لو مش لاقي
    }
  }

  String mapArEmploymentStatus(String statusAr) {
    switch (statusAr) {
      case "موظف":
        return "Employed";
      case "غير موظف":
        return "Job Seeker";
      case "عامل حر":
        return "Freelancer";
      case "طالب دراسات عليا":
        return "Postgraduate Studies";
      default:
        return "Job Seeker"; // default لو مش لاقي
    }
  }




  // final List<int> level = [1, 2, 3, 4, 5];
  // final List<String> department = ["IT", "CS", "IS", "AI"];
  final List<String> language = ["العربية", "الانجليزية"];


  Future<void> getProfile() async {
    emit(LoadingState(loadingMessage: 'Loading...'));

    var either = await repository.getProfile();

    either.fold(
          (failure) {
        emit(ErrorState(errorMessage: failure.error?.message ?? "فشل في تحميل البيانات"));
      },
          (response) async {
        final user = response.data?.user;
        final graduated = response.data?.user?.graduatedData;
        userRole = response.data?.user?.role ?? '';


        if (user == null) {
          emit(ErrorState(errorMessage: "بيانات المستخدم غير متوفرة"));
          return;
        }

        if (graduated != null && graduated.cv != null && graduated.cv!.isNotEmpty) {
          cvUrl = graduated.cv;
          cvFileName = graduated.cv!.split('/').last; // آخر جزء من اللينك
          cvController.text = cvFileName!; // عشان يظهر الاسم في الـ UI
        } else {
          cvUrl = null;
          cvController.text = 'لا يوجد ملف سيرة ذاتية';
        }


        // تحميل صورة البروفايل
        if (user.baseImage64 != null && user.baseImage64!.isNotEmpty) {
          profileImageUrl = "${user.baseImage64 }?t=${DateTime.now().millisecondsSinceEpoch}";
        } else {
          profileImageUrl = "assets/images/Ellipse.png";
        }

        // بيانات عامة
        userNameController.text = user.name ?? '';
        emailController.text = user.email ?? '';


        // لو طالب
        if (user.role == "Student") {
          isGraduated = false;
          levelController.text = user.level?.toString() ?? '';
          departmentController.text = user.department ?? '';
          emit(ProfileSuccessState(userProfile: user));
        }

        // لو خريج
        else if (user.role == "Graduated") {
          isGraduated = true;
          if (graduated == null) {
            emit(ErrorState(errorMessage: "بيانات الخريج غير متوفرة"));
            return;
          }

          if (graduated.employmentStatus != null && graduated.employmentStatus!.isNotEmpty) {
            final arabicStatus = mapEmploymentStatus(graduated.employmentStatus!);
            employmentStatusController.text = arabicStatus;
            selectedEmploymentStatus = arabicStatus;
          } else {
            employmentStatusController.text = '';
            selectedEmploymentStatus = 'حالة الوظيفة';
          }
          jobTitleController.text = graduated.jobTitle ?? '';
          companyLocationController.text = graduated.companyLocation ?? '';
          companyLinkController.text = graduated.companyLink ?? '';
          cvController.text = graduated.cv ?? '';

          emit(GradProfileSuccessState(userProfile: graduated));
        }


        else {
          emit(ErrorState(errorMessage: "نوع المستخدم غير معروف"));
        }
      },
    );

  }



  Future<void> pickCVFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], // الأفضل نخليها PDF فقط لأن الـ backend بيطلب كده
    );

    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);

      // تأكد إنه فعلاً PDF
      if (!file.path.toLowerCase().endsWith('.pdf')) {
        debugPrint('❌ Only PDF files are allowed');
        return;
      }

      // خزّني الملف نفسه علشان نرفعه لاحقاً
      resumeFile = file;

      // بيعرض اسم الملف فقط في الـ TextField للعرض
      cvController.text = result.files.single.name;

      debugPrint('✅ CV file selected: ${file.path}');
    } else {
      debugPrint('⚠️ No file selected');
    }
  }






  // void getProfile() async {
  //   emit(LoadingState(loadingMessage: 'Loading...'));
  //   var either = await repository.getProfile();
  //   either.fold(
  //         (l) {
  //       emit(ErrorState(errorMessage: l.error?.message));
  //     },
  //         (response) async {
  //
  //
  //       final user = response.data!.user!;
  //       if (user.baseImage64 != null && user.baseImage64!.isNotEmpty) {
  //         profileImageUrl = "${user.baseImage64}?t=${DateTime.now().millisecondsSinceEpoch}";
  //       } else {
  //         profileImageUrl = "assets/images/Ellipse.png"; // صورة افتراضية
  //       }
  //
  //
  //       userNameController.text = user.name ?? '';
  //       emailController.text = user.email ?? '';
  //       levelController.text = user.level?.toString() ?? '';
  //       departmentController.text = user.department ?? '';
  //
  //
  //
  //
  //       // ✅ تحميل الصورة من السيرفر أو وضع صورة افتراضية
  //      // final prefs = await SharedPreferences.getInstance();
  //
  //       // ✅ لو فيه صورة من السيرفر
  //       if (user.baseImage64 != null && user.baseImage64!.isNotEmpty) {
  //         profileImageUrl = user.baseImage64!;
  //       } else {
  //         // 🩵 مفيش → نحط الصورة الافتراضية
  //         profileImageUrl = "assets/images/Ellipse.png";
  //       }
  //
  //      // await prefs.setString("profileImageUrl", profileImageUrl!);
  //
  //       emit(ProfileSuccessState(userProfile: user));
  //     },
  //   );
  // }

  // Future<void> updateProfile() async {
  //   if (!formKey.currentState!.validate()) return;
  //
  //   emit(LoadingState(loadingMessage: 'جارٍ تحديث البيانات...'));
  //
  //   // ✅ لو فيه صورة جديدة، نرفعها الأول
  //   String? uploadedImageUrl;
  //   if (image != null) {
  //     try {
  //       final bytes = await image!.readAsBytes();
  //       final base64Image = base64Encode(bytes);
  //       final request = ImageRequest(baseImage64: "data:image/png;base64,$base64Image");
  //
  //       final either = await repository.uploadProfileImage(request);
  //       await either.fold(
  //             (failure) async {
  //           emit(ErrorState(errorMessage: failure.error?.message ?? "فشل في رفع الصورة"));
  //         },
  //             (response) async {
  //           uploadedImageUrl = response.data?.imageUrl;
  //          // final prefs = await SharedPreferences.getInstance();
  //           if (uploadedImageUrl != null && uploadedImageUrl!.isNotEmpty) {
  //          //   await prefs.setString("profileImageUrl", uploadedImageUrl!);
  //             profileImageUrl = uploadedImageUrl!;
  //
  //
  //           }
  //         },
  //       );
  //     } catch (e) {
  //       emit(ErrorState(errorMessage: "حدث خطأ أثناء رفع الصورة: $e"));
  //       return;
  //     }
  //   }
  //
  //   // ✏️ بعد رفع الصورة نعمل تحديث البيانات
  //   final request = UpdateProfileRequest(
  //     name: userNameController.text.trim(),
  //     email: emailController.text.trim(),
  //     level: int.tryParse(levelController.text.trim()) ?? 1,
  //     department: departmentController.text.trim(),
  //   );
  //
  //   var either = await repository.updateData(request);
  //
  //   either.fold(
  //         (failure) {
  //       emit(ErrorState(errorMessage: failure.error?.message ?? "حدث خطأ أثناء التحديث"));
  //     },
  //         (response) async {
  //       emit(UpdateProfileSuccessState(userUpdate: response.data!.user!));
  //       isEditable = false;
  //       await getProfile();
  //     },
  //   );
  // }

  Future<void> updateProfile() async {
    if (!formKey.currentState!.validate()) return;
    emit(LoadingState(loadingMessage: 'جارٍ تحديث البيانات...'));

    // 🔹 رفع الصورة لو فيه
    String? uploadedImageUrl;
    if (image != null) {
      try {
        final bytes = await image!.readAsBytes();
        final base64Image = base64Encode(bytes);
        final request = ImageRequest(baseImage64: "data:image/png;base64,$base64Image");
        final either = await repository.uploadProfileImage(request);
        await either.fold(
              (failure) async {
            emit(ErrorState(errorMessage: failure.error?.message ?? "فشل في رفع الصورة"));
          },
              (response) async {
            uploadedImageUrl = response.data?.imageUrl;
            if (uploadedImageUrl != null && uploadedImageUrl!.isNotEmpty) {
              profileImageUrl = uploadedImageUrl!;
            }
          },
        );
      } catch (e) {
        emit(ErrorState(errorMessage: "حدث خطأ أثناء رفع الصورة: $e"));
        return;
      }
    }

    // 🔹 بناء الريكويست حسب النوع
    UpdateProfileRequest request;

    if (isGraduated) {
      // 💡 هنا التعديل المهم:
      String? employmentStatusAr = selectedEmploymentStatus;
      String employmentStatusEn = mapArEmploymentStatus(employmentStatusAr);

      // لو الحالة مش "موظف" امسح بيانات الوظيفة فقط (سيب الـ CV)
      if (employmentStatusAr != "موظف") {
        jobTitleController.text = "";
        companyLocationController.text = "";
        companyLinkController.text = "";
      }

      request = UpdateProfileRequest(
        name: userNameController.text.trim(),
        email: emailController.text.trim(),
        department: departmentController.text.trim(),
        graduatedData: GraduatedData(
          cv: resumeFile, // 🟢 دايماً يتبعت زي ما هو
          employmentStatus: employmentStatusEn,
          jobTitle: jobTitleController.text.trim().isEmpty
              ? null
              : jobTitleController.text.trim(),
          companyLocation: companyLocationController.text.trim().isEmpty
              ? null
              : companyLocationController.text.trim(),
          companyLink: companyLinkController.text.trim().isEmpty
              ? null
              : companyLinkController.text.trim(),
        ),
      );
    } else {
      request = UpdateProfileRequest(
        name: userNameController.text.trim(),
        email: emailController.text.trim(),
        level: int.tryParse(levelController.text.trim()) ?? 1,
        department: departmentController.text.trim(),
      );
    }

    // 📡 إرسال الطلب
    var either = await repository.updateData(request);

    either.fold(
          (failure) {
        emit(ErrorState(errorMessage: failure.error?.message ?? "حدث خطأ أثناء التحديث"));
      },
          (response) async {
        emit(UpdateProfileSuccessState(userUpdate: response.data!.user!));
        userNameController.text = response.data!.user!.name ?? '';
        emailController.text = response.data!.user!.email ?? '';

        if (response.data!.user!.graduatedData != null) {
          final grad = response.data!.user!.graduatedData!;
          employmentStatusController.text = mapEmploymentStatus(grad.employmentStatus ?? '');
          jobTitleController.text = grad.jobTitle ?? '';
          companyLocationController.text = grad.companyLocation ?? '';
          companyLinkController.text = grad.companyLink ?? '';
          // cvController.text = grad.cv != null
          //     ? grad.cv!
          //     : cvUrl ?? '';
          if (grad.cv != null && grad.cv!.isNotEmpty) {
            cvUrl = grad.cv;
            cvFileName = grad.cv!.split('/').last; // 🟢 آخر جزء فقط من اللينك
            cvController.text = cvFileName!;
          } else {
            cvUrl = null;
            cvController.text = 'لا يوجد ملف سيرة ذاتية';
          }


        }

        isEditable = false;
        await getProfile();
      },
    );
  }

  Future<void> pickProfileImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;

      image = File(pickedFile.path);
      profileImageUrl = image!.path; // ← تخليها تظهر فورًا في الـ UI
      emit(UploadImageSuccessState(profileImageUrl ?? ""));
    } catch (e) {
      emit(ErrorState(errorMessage: "حدث خطأ أثناء اختيار الصورة: $e"));
    }
  }
  Future<void> deleteProfile(BuildContext context) async {
    emit(LoadingState(loadingMessage: 'جارٍ حذف الحساب...'));

    final either = await repository.deleteProfile();

    await either.fold(
          (failure) {
        emit(ErrorState(errorMessage: failure.error?.message ?? "حدث خطأ أثناء حذف الحساب"));
      },
          (response) async {
        // 🧹 مسح البيانات المحلية
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();

        Navigator.pushReplacementNamed(context, AccountType.routeName);
        // 🟢 إظهار رسالة نجاح
        emit(DeleteProfileSuccessState(response));

      },
    );
  }

  void clearData() {
    // مسح كل البيانات المؤقتة في الذاكرة
    userNameController.clear();
    emailController.clear();
    levelController.clear();
    departmentController.clear();
    languageController.clear();

    profileImageUrl = null;
    image = null;
    isEditable = false;

    emit(InitialState()); // نرجّع الحالة للبداية
  }


  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // 🧠 امسحي بيانات البروفايل
    context.read<ProfileViewModel>().clearData();

    // ✅ امسحي بيانات الشات
    try {
      final chatCubit = context.read<ChatCubit>();
      chatCubit.disconnect(); // يفصل السوكت القديم
      await chatCubit.close();
    } catch (e) {
      debugPrint("⚠️ ChatCubit not found — skipping cleanup");
    }

    // 🚪 رجّعي المستخدم لشاشة اختيار الحساب
    Navigator.pushNamedAndRemoveUntil(
      context,
      AccountType.routeName,
          (route) => false,
    );
  }





}
