import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Request/CompleteProfileRequest.dart';
import 'package:smart_college/Models/Response/CompleteProfileResponse.dart';
import 'package:smart_college/Models/Response/DepartmentResponse.dart';

import '../../../Models/Request/studentRegisterRequest.dart';
import '../../../Models/Response/LevelResponse.dart';
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

  List<DataLevel> levelsList = [];


  List<DataDepartment> department = [];

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


  Future<void> getLevels() async {
    emit(RegisterLoadingState(loadingMessage: "Loading levels..."));
    try {
      final response = await repository.getLevel(); // نادِ الـ API

      response.fold(
            (error) {
          emit(RegisterErrorState(errorMessage: error.error!.message));
        },
            (data) {
              print("Levels response: ${data.data}");

              levelsList = data.data ?? [];
              print("Levels response: ${levelsList.length}");

              emit(LevelSuccessState(dataLevel: levelsList)); // State جديد
        },
      );
    } catch (e) {
      emit(RegisterErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> getDepartment() async {
    emit(RegisterLoadingState(loadingMessage: "Loading levels..."));
    try {
      final response = await repository.getDepartment(); // نادِ الـ API

      response.fold(
            (error) {
          emit(RegisterErrorState(errorMessage: error.error!.message));
        },
            (data) {
          print("Levels response: ${data.data}");

          department = data.data ?? [];
          print("Levels response: ${department.length}");

          emit(DepartmentSuccessState(dataDepartment: department)); // State جديد
        },
      );
    } catch (e) {
      emit(RegisterErrorState(errorMessage: e.toString()));
    }
  }


  void clearForm() {
    emailController.clear();
    passwordController.clear();
    rePasswordController.clear();
    userNameController.clear();
    levelController.clear();
    departmentController.clear();

    isChecked = false;
    isPasswordVisible = true;
    isRePasswordVisible = true;

    emit(RegisterInitialState());
  }

}



