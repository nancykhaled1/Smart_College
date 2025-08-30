import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_college/Models/Request/ChangePasswordRequest.dart';
import 'package:smart_college/Models/Request/ResetPasswordRequest.dart';
import 'package:smart_college/Repositories/ChangePasswordRepository.dart';
import 'package:smart_college/Repositories/ResetPasswordRepository.dart';
import 'States.dart';

class RePasswordCubit extends Cubit<LoginStates> {
  final ChangePasswordRepository repository;

  RePasswordCubit(this.repository) : super(LoginInitialState());

  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isPasswordVisible = true;
  bool isRePasswordVisible = true;


  Future<void> changePassword({required String email, required String code , required String newPassword}) async {
    emit(LoginLoadingState(loadingMessage: "Loading..."));

    final request = ChangePasswordRequest(
      email: email,
      code: code,
      newPassword: newPassword
    );

    final response = await repository.changePassword(request);

    response.fold(
          (error) {
        emit(LoginErrorState(errorMessage: error.error?.message));
      },
          (data) {
        if (data.success == true) {
          emit(ChangePassSuccessState(response: data));
        } else {
          emit(LoginErrorState(errorMessage: data.data?.message ?? "حدث خطأ غير متوقع"));
        }

      },
    );
  }
}
