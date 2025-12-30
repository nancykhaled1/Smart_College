import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_college/Cubits/lectures/lectureState.dart';
import 'package:smart_college/Repositories/LectureRepositort.dart';


class LectureCubit extends Cubit<LectureState> {
  final LectureRepository repository;

  LectureCubit(this.repository) : super(LectureInitial());

  /// 🔹 Get all lectures
  Future<void> getLectures() async {
    emit(LectureLoading());

    final response = await repository.getLectures();

    response.fold(
      (error) {
        emit(
          LectureError(
            error.error?.message ?? "حدث خطأ أثناء تحميل المحاضرات",
            error.error?.code ?? 0,
          ),
        );
      },
      (lectures) {
        emit(LectureSuccess(lectures));
      },
    );
  }

  /// 🔹 Get lecture details by id
  Future<void> getLectureById(String id) async {
    emit(LectureDetailLoading());

    final response = await repository.getLectureById(id);

    response.fold(
      (error) {
        emit(
          LectureDetailError(
            error.error?.message ?? "حدث خطأ أثناء تحميل تفاصيل المحاضرة",
            error.error?.code ?? 0,
          ),
        );
      },
      (lecture) {
        emit(LectureDetailSuccess(lecture));
      },
    );
  }
}
