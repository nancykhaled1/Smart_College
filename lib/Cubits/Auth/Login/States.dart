import 'package:smart_college/Models/Response/ChangePaswwordResponse.dart';
import 'package:smart_college/Models/Response/GoogleResponse.dart';
import 'package:smart_college/Models/Response/LoginResponse.dart';
import 'package:smart_college/Models/Response/ResetPasswordResponse.dart';
import 'package:smart_college/Models/Response/SendEmailResponse.dart';
import 'package:smart_college/Models/Response/VerifyEmailResponse.dart';

import '../../../Models/Response/StudentRegisterResponse.dart';

abstract class LoginStates{}

class LoginInitialState extends LoginStates{}
class LoginLoadingState extends LoginStates{
  String? loadingMessage;
  LoginLoadingState({required this.loadingMessage});
}
class LoginErrorState extends LoginStates{
  String? errorMessage;
  LoginErrorState({required this.errorMessage});
}

class LoginSuccessState extends LoginStates {
  final LoginResponse response;

  LoginSuccessState({required this.response});
}

class SendEmailSuccessState extends LoginStates {
  final SendEmailResponse response;

  SendEmailSuccessState({required this.response});
}


class ResetPassSuccessState extends LoginStates {
  final ResetPasswordResponse response;

  ResetPassSuccessState({required this.response});
}

class ChangePassSuccessState extends LoginStates {
  final ChangePaswwordResponse response;

  ChangePassSuccessState({required this.response});
}

class GoogleSuccessState extends LoginStates {
  final GoogleResponse response;

  GoogleSuccessState({required this.response});
}
