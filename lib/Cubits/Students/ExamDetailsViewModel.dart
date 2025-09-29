import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_college/Cubits/States/States.dart';
import 'package:smart_college/Repositories/ExamsRepository.dart';


class ExamDetailsViewModel extends Cubit<States> {
  final ExamsRepository examsRepository;
  Timer? _timer;
  Duration remainingTime = Duration.zero;
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


  void startAttempt(String examId) async {
    emit(LoadingState(loadingMessage: 'جارى بدء الامتحان...'));

    var either = await examsRepository.startAttempt(examId);

    either.fold(
          (l) {
        emit(ErrorState(errorMessage: l.error?.message ?? "فشل في بدء الامتحان"));
      },
          (success) {

        final attempt = success.data?.attempt;
            final endAt = DateTime.parse(attempt?.endAt ?? '');
        // 🕒 حساب الوقت المتبقي
        remainingTime = endAt.difference(DateTime.now());

        // 🚀 بدء العداد
        _startTimer();
        if (attempt != null) {
          emit(StartAttemptSuccessState(attempt: attempt, remaining: remainingTime));
        } else {
          emit(ErrorState(errorMessage: "لم يتم إنشاء محاولة الامتحان"));
        }
      },
    );
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.inSeconds > 0) {
        remainingTime = remainingTime - const Duration(seconds: 1);
        emit(TimerTickState(remaining: remainingTime));
      } else {
        timer.cancel();
        emit(TimerFinishedState());
        // هنا ممكن تعمل auto-submitAttempt
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }



}
