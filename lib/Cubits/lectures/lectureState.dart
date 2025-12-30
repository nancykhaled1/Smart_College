import 'package:smart_college/Models/Response/subject_model.dart';

class LectureState {}

class LectureInitial extends LectureState {}

class LectureLoading extends LectureState {}

class LectureSuccess extends LectureState {
  final List<LectureModel> lectures;
  LectureSuccess(this.lectures);
}

class LectureError extends LectureState {
  final String message;
  final int code;
  LectureError(this.message, this.code);
}

class LectureDetailLoading extends LectureState {}

class LectureDetailSuccess extends LectureState {
  final LectureModel lecture;
  LectureDetailSuccess(this.lecture);
}

class LectureDetailError extends LectureState {
  final String message;
  final int code;
  LectureDetailError(this.message, this.code);
}
