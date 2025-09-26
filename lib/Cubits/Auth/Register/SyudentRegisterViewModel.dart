import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Request/CompleteProfileRequest.dart';
import 'package:smart_college/Models/Response/CompleteProfileResponse.dart';

import '../../../Models/Request/studentRegisterRequest.dart';
import '../../../Models/Response/StudentRegisterResponse.dart';
import '../../../Models/Response/registerError.dart';
import '../../../Repositories/StudentRegisterRepository.dart';
import '../../../services/local/sharedPreference.dart';
import 'States.dart';


class RegisterCubit extends Cubit<RegisterStates> {
  final StudentRepository repository;

  RegisterCubit(this.repository) : super(RegisterInitialState());


  var formKey = GlobalKey<FormState>();
  var profileFormKey = GlobalKey<FormState>();


  TextEditingController emailController =
  TextEditingController();

  TextEditingController passwordController =
  TextEditingController();

  TextEditingController rePasswordController =
  TextEditingController();

  TextEditingController userNameController =
  TextEditingController();

  TextEditingController levelController =
  TextEditingController();

  TextEditingController departmentController =
  TextEditingController();


  bool isPasswordVisible = true;
  bool isRePasswordVisible = true;
  bool showDropdownlevel = false;
  bool showDropdowndepartment= false;
  bool isChecked = false;

  final List<int> level = [
    1,
    2,
    3,
    4,
    5,
  ];

  final List<String> department = [
    "IT",
    "CS",
    "IS",
    "AI"
  ];

  Future<void> registerStudent({required String role}) async {
    if (!formKey.currentState!.validate()) return;

    emit(RegisterLoadingState(loadingMessage: "Registering..."));

    final request = StudentRegisterRequest(
      name: userNameController.text,
      email: emailController.text,
      password: passwordController.text,
      role: role,
      level: levelController.text,
        department: departmentController.text

    );

    Either<RegisterError, StudentRegisterResponse> response =
    await repository.registerStudent(request);

    response.fold(
          (error) {
        emit(RegisterErrorState(errorMessage: error.error!.message));
      },
          (data) async {
            final savedRole = await TokenStorage.getRole();
            print("Saved role locally: $savedRole");


            TokenStorage.saveId(data.data!.userId!);
            final savedUserId = await TokenStorage.getUserId();
            print("Saved token locally: $savedUserId");
        emit(RegisterSuccessState(response: data));
      },
    );
  }


  Future<void> completeProfile() async {
    if (!profileFormKey.currentState!.validate()) return;

    emit(RegisterLoadingState(loadingMessage: "Registering..."));

    final request = CompleteProfileRequest(
        level:levelController.text,
        department: departmentController.text

    );

    Either<RegisterError, CompleteProfileResponse> response =
    await repository.completeProfile(request);

    response.fold(
          (error) {
        emit(RegisterErrorState(errorMessage: error.error!.message));
      },
          (data) async {
        final savedRole = await TokenStorage.getRole();
        print("Saved role locally: $savedRole");

        TokenStorage.saveId(data.data?.user?.id ??'');
        final savedUserId = await TokenStorage.getUserId();
        print("Saved token locally: $savedUserId");
        emit(ProfileSuccessState(response: data));
      },
    );
  }
}



