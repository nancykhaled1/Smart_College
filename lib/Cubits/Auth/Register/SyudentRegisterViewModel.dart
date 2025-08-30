import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';

import '../../../Models/Request/studentRegisterRequest.dart';
import '../../../Models/Response/StudentRegisterResponse.dart';
import '../../../Models/Response/registerError.dart';
import '../../../Repositories/StudentRegisterRepository.dart';
import 'States.dart';


class RegisterCubit extends Cubit<RegisterStates> {
  final StudentRepository repository;

  RegisterCubit(this.repository) : super(RegisterInitialState());


  var formKey = GlobalKey<FormState>();

  TextEditingController emailController =
  TextEditingController();

  TextEditingController passwordController =
  TextEditingController();

  TextEditingController rePasswordController =
  TextEditingController();

  TextEditingController userNameController =
  TextEditingController();

  bool isPasswordVisible = true;
  bool isRePasswordVisible = true;

  bool isChecked = false;

  Future<void> registerStudent({required String role}) async {
    if (!formKey.currentState!.validate()) return;

    emit(RegisterLoadingState(loadingMessage: "Registering..."));

    final request = StudentRegisterRequest(
      name: userNameController.text,
      email: emailController.text,
      password: passwordController.text,
      role: role,

    );

    Either<RegisterError, StudentRegisterResponse> response =
    await repository.registerStudent(request);

    response.fold(
          (error) {
        emit(RegisterErrorState(errorMessage: error.error!.message));
      },
          (data) {
        emit(RegisterSuccessState(response: data));
      },
    );
  }
}



