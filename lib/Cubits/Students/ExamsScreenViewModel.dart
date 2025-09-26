import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_college/Cubits/States/States.dart';
import 'package:smart_college/Models/Response/ExamsResponse.dart';
import 'package:smart_college/Repositories/ExamsRepository.dart';


class ExamsScreenViewModel extends Cubit<States> {
  final ExamsRepository examsRepository;
  ExamsScreenViewModel( this.examsRepository)
      : super(InitialState());

  List<Exams> examsList = [];



  void getExams() async {
    emit(LoadingState(loadingMessage: 'Loading...'));
    var either = await examsRepository.getExams();
    either.fold(
          (l) {
        emit(ErrorState(errorMessage: l.error?.message));
      },

          (response) {
            examsList = response.data?.exams ?? [];
        emit(ExamsSuccessState(exams: examsList));
      },

    );
  }
  void getExamDetails(String examId) async {
    emit(LoadingState(loadingMessage: 'جارى التحميل')); // ⬅️ عشان يمسح القديم ويعرض loader

    var either = await examsRepository.getExamById(examId);
    either.fold(
            (l) {
          emit(ErrorState(errorMessage: l.error?.message));
        },
            (success) {
          emit(ExamDetailsSuccessState(examDetails: success.data!.exam!));
        }

    );
  }


}
