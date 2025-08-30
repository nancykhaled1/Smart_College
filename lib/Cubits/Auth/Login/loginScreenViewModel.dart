import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_college/Models/Request/LoginRequest.dart';
import 'package:smart_college/Models/Response/LoginError.dart';
import 'package:smart_college/Models/Response/LoginResponse.dart';
import 'package:smart_college/Repositories/LoginRepository.dart';
import '../../../services/local/sharedPreference.dart';
import 'States.dart';

class LoginScreenCubit extends Cubit<LoginStates> {
  final LoginRepository repository;

  LoginScreenCubit(this.repository) : super(LoginInitialState());

  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = true;
  bool isChecked = false;

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoadingState(loadingMessage: "Loading..."));

      final request = LoginRequest(
        email: emailController.text,
        password: passwordController.text,
      );

      Either<LoginError, LoginResponse> response =
      await repository.login(request);

      response.fold(
            (error) {
          emit(LoginErrorState(errorMessage: error.error!.message));
        },
            (data) async {
          // هنا جالك التوكن من السيرفر
          final token = data.data?.token; // تأكدي إن اسم الفيلد هو token


          // خزنه محليًا
          await TokenStorage.saveToken(token!);
          final savedToken = await TokenStorage.getToken();
          print("Saved token locally: $savedToken");

          // ابعتي الـ Success State
          emit(LoginSuccessState(response: data));
        },
      );
    }
  }
}
