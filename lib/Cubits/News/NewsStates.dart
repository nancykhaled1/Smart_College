import 'package:smart_college/Models/Response/newsModel.dart';

abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsLoadingState extends NewsStates {
  String? loadingMessage;
  NewsLoadingState({this.loadingMessage});
}

class NewsErrorState extends NewsStates {
  String? errorMessage;
  NewsErrorState({required this.errorMessage});
}

class NewsSuccessState extends NewsStates {
  final NewsResponse response;

  NewsSuccessState({required this.response});
}

// News Detail States
class NewsDetailLoadingState extends NewsStates {
  String? loadingMessage;
  NewsDetailLoadingState({this.loadingMessage});
}

class NewsDetailErrorState extends NewsStates {
  String? errorMessage;
  NewsDetailErrorState({required this.errorMessage});
}

class NewsDetailSuccessState extends NewsStates {
  final NewsDetailResponse response;

  NewsDetailSuccessState({required this.response});
}

