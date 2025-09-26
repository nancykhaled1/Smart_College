import 'package:smart_college/Models/Response/CompleteProfileResponse.dart';
import 'package:smart_college/Models/Response/VerifyEmailResponse.dart';

import '../../../Models/Response/StudentRegisterResponse.dart';

abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates{}
class RegisterLoadingState extends RegisterStates{
  String? loadingMessage;
  RegisterLoadingState({required this.loadingMessage});
}
class RegisterErrorState extends RegisterStates{
  String? errorMessage;
  RegisterErrorState({required this.errorMessage});
}

class RegisterSuccessState extends RegisterStates {
  final StudentRegisterResponse response;

  RegisterSuccessState({required this.response});
}

class ProfileSuccessState extends RegisterStates {
  final CompleteProfileResponse response;

  ProfileSuccessState({required this.response});
}

class AlumniRegisterSuccessState extends RegisterStates {
  final StudentRegisterResponse response;

  AlumniRegisterSuccessState({required this.response});
}


class VerifyEmailSuccessState extends RegisterStates {
  final VerifyEmailResponse response;

  VerifyEmailSuccessState({required this.response});
}