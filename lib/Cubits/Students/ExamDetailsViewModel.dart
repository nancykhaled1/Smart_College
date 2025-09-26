import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_college/Cubits/States/States.dart';
import 'package:smart_college/Repositories/ExamsRepository.dart';


class ExamDetailsViewModel extends Cubit<States> {
  final ExamsRepository examsRepository;
  ExamDetailsViewModel( this.examsRepository)
      : super(InitialState());



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
