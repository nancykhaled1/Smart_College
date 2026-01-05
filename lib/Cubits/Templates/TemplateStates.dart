import 'package:smart_college/Models/Response/templateModel.dart';

abstract class TemplateStates {}

class TemplateInitialState extends TemplateStates {}

class TemplateLoadingState extends TemplateStates {
  String? loadingMessage;
  TemplateLoadingState({this.loadingMessage});
}

class TemplateErrorState extends TemplateStates {
  String? errorMessage;
  TemplateErrorState({required this.errorMessage});
}

class TemplateSuccessState extends TemplateStates {
  final TemplateResponse response;

  TemplateSuccessState({required this.response});
}

// Template Detail States
class TemplateDetailLoadingState extends TemplateStates {
  String? loadingMessage;
  TemplateDetailLoadingState({this.loadingMessage});
}

class TemplateDetailErrorState extends TemplateStates {
  String? errorMessage;
  TemplateDetailErrorState({required this.errorMessage});
}

class TemplateDetailSuccessState extends TemplateStates {
  final TemplateDetailResponse response;

  TemplateDetailSuccessState({required this.response});
}

// Template Search States
class TemplateSearchLoadingState extends TemplateStates {
  String? loadingMessage;
  TemplateSearchLoadingState({this.loadingMessage});
}

class TemplateSearchErrorState extends TemplateStates {
  String? errorMessage;
  TemplateSearchErrorState({required this.errorMessage});
}

class TemplateSearchSuccessState extends TemplateStates {
  final TemplateResponse response;
  TemplateSearchSuccessState({required this.response});
}

