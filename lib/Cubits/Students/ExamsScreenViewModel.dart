import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_college/Cubits/States/States.dart';
import 'package:smart_college/Models/Response/ExamsResponse.dart';
import 'package:smart_college/Repositories/ExamsRepository.dart';

import '../../Models/Response/QuestionsResponse.dart';


class ExamsScreenViewModel extends Cubit<States> {
  final ExamsRepository examsRepository;
  ExamsScreenViewModel(this.examsRepository) : super(InitialState());

  List<Exams> examsList = [];

  // المتغيرات الخاصة بالامتحان
  int currentQuestionIndex = 0;
  int? selectedAnswerIndex;
  final TextEditingController shortAnswerController = TextEditingController();
  List<Questions> questions = [];
  String? shortAnswer; // 🟢 متغير جديد يخزن الإجابة النصية


  void getExams() async {
    emit(LoadingState(loadingMessage: 'جارى التحميل'));
    var either = await examsRepository.getExams();
    either.fold(
          (l) => emit(ErrorState(errorMessage: l.error?.message)),
          (response) {
        examsList = response.data?.exams ?? [];
        emit(ExamsSuccessState(exams: examsList));
      },
    );
  }

  void getQuestions(String examId) async {
    emit(LoadingState(loadingMessage: 'جارى التحميل'));

    var either = await examsRepository.getQuestions(examId);
    either.fold(
          (l) => emit(ErrorState(errorMessage: l.error?.message)),
          (success) {
         questions = success.data?.questions ?? [];
        currentQuestionIndex = 0;
        selectedAnswerIndex = null;
        shortAnswerController.clear();
        emit(QuestionsSuccessState(questions: questions));
      },
    );
  }

  void selectAnswer(int index) {
    selectedAnswerIndex = index;
    emit(QuestionUpdatedState(
      currentIndex: currentQuestionIndex,
      selectedAnswerIndex: selectedAnswerIndex,
      shortAnswer: shortAnswerController.text,
    ));
  }

  void setShortAnswer(String text) {
    shortAnswer = text; // 🟢 نخزن القيمة
    emit(QuestionUpdatedState(
      currentIndex: currentQuestionIndex,
      selectedAnswerIndex: selectedAnswerIndex,
      shortAnswer: text,
    ));
  }

  void goToNextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
      selectedAnswerIndex = null;
      shortAnswerController.clear();
      shortAnswer = null; // 🟢 نفضي الإجابة لما ننتقل للسؤال الجديد
      emit(QuestionUpdatedState(
        currentIndex: currentQuestionIndex,
        selectedAnswerIndex: null,
        shortAnswer: "",
      ));
    } else {
      emit(ExamFinishedState());
    }
  }

  void goToPreviousQuestion() {
    if (currentQuestionIndex > 0) {
      currentQuestionIndex--;
      selectedAnswerIndex = null;
      shortAnswerController.clear();
      emit(QuestionUpdatedState(
        currentIndex: currentQuestionIndex,
        selectedAnswerIndex: null,
        shortAnswer: "",
      ));
    }
  }
}
