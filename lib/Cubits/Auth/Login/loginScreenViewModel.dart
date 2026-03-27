import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_college/Models/Request/LoginRequest.dart';
import 'package:smart_college/Models/Response/LoginError.dart';
import 'package:smart_college/Models/Response/LoginResponse.dart';
import 'package:smart_college/Repositories/LoginRepository.dart';
import '../../../services/local/sharedPreference.dart';
import '../../States/States.dart';

class LoginScreenCubit extends Cubit<States> {
  final LoginRepository repository;

  LoginScreenCubit(this.repository) : super(InitialState());

  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = true;
  bool isChecked = false;

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      emit(LoadingState(loadingMessage: "Loading..."));

      final request = LoginRequest(
        email: emailController.text,
        password: passwordController.text,
      );

      Either<LoginError, LoginResponse> response =
      await repository.login(request);

      response.fold(
            (error) {
          emit(ErrorState(errorMessage: error.error!.message));
        },
            (data) async {

          //تخزين التوكن
          final token = data.data?.token;
          await TokenStorage.saveToken(token!);
          final savedToken = await TokenStorage.getToken();
          print("Saved token locally: $savedToken");

          //تخزين الرول
          final role = data.data?.user?.role;
          await TokenStorage.saveRole(role!);
          final savedRole = await TokenStorage.getRole();
          print("Saved role locally: $savedRole");

          //تخزين ال id
          final userId = data.data?.user?.id;
          await TokenStorage.saveId(userId!);
          final savedUserId = await TokenStorage.getUserId();
          print("Saved id locally: $savedUserId");


          emit(LoginSuccessState(response: data));
        },
      );
    }
  }
}




