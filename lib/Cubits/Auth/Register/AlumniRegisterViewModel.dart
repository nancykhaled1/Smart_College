import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Request/AlumniRegisterRequest.dart';
import 'package:smart_college/Repositories/AlumniRegisterRepository.dart';

import '../../../Models/Request/studentRegisterRequest.dart';
import '../../../Models/Response/StudentRegisterResponse.dart';
import '../../../Models/Response/registerError.dart';
import '../../../Repositories/StudentRegisterRepository.dart';
import '../../../services/local/sharedPreference.dart';
import 'States.dart';


class AlumniRegisterCubit extends Cubit<RegisterStates> {
  final AlumniRepository repository;

  AlumniRegisterCubit(this.repository) : super(RegisterInitialState());

  var formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController cvController = TextEditingController();
  TextEditingController employmentStatusController = TextEditingController();
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController companyLocationController = TextEditingController();
  TextEditingController companyEmailController = TextEditingController();
  TextEditingController companyLinkController = TextEditingController();
  TextEditingController companyPhoneController = TextEditingController();
  TextEditingController aboutCompanyController = TextEditingController();


  bool isPasswordVisible = true;
  bool isRePasswordVisible = true;
  bool isChecked = false;

  bool showField = false;
  bool showDropdown = false;
  bool showDropdownlocation = false;
  String selectedEmploymentStatus = "حالة الوظيفة";
  File? resumeFile;



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

  String mapEmploymentStatus(String statusAr) {
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


  Future<void> registerAlumni({required String role}) async {
    if (!formKey.currentState!.validate()) return;

    emit(RegisterLoadingState(loadingMessage: "Registering..."));

    final request = AlumniRegisterRequest(
      name: userNameController.text,
      email: emailController.text,
      password: passwordController.text,
      role: role,
      graduatedData: GraduatedData(
        cv: resumeFile, // ✅ هنا بنبعت الفايل مش النص
        employmentStatus: mapEmploymentStatus(employmentStatusController.text),
        jobTitle: jobTitleController.text.isEmpty ? "N/A" : jobTitleController.text,
        companyLocation: companyLocationController.text.isEmpty ? "N/A" : companyLocationController.text,
        companyEmail: "N/A",
        companyLink: companyLinkController.text.isEmpty ? "N/A" : companyLinkController.text,
        companyPhone: "N/A",
        aboutCompany: "N/A",
      ),
    );

    print("🟢 Sending alumni register request...");
    print(request.toJson());

    Either<RegisterError, StudentRegisterResponse> response =
    await repository.registerAlumni(request);

    response.fold(
          (error) {
        emit(RegisterErrorState(errorMessage: error.error!.message));
      },
          (data) async {
        await TokenStorage.saveId(data.data!.userId!);
        print("✅ Saved user ID locally");

        emit(AlumniRegisterSuccessState(response: data));
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




}




