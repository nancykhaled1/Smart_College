import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_college/Cubits/States/States.dart';
import 'package:smart_college/Models/Response/ExamsResponse.dart';
import 'package:smart_college/Models/Response/MyAttemptsResponse.dart';
import 'package:smart_college/Models/Response/QuestionsResponse.dart';
import 'package:smart_college/Models/Response/SaveAnswersResponse.dart';
import 'package:smart_college/Repositories/ExamsRepository.dart';

class ExamsScreenViewModel extends Cubit<States> {
  final ExamsRepository examsRepository;

  ExamsScreenViewModel(this.examsRepository) : super(InitialState());

  List<Exams> examsList = [];
  List<MyAttempts> attemptList = [];

  List<Questions> questions = [];

  int currentQuestionIndex = 0;
  int? selectedAnswerIndex;
  final TextEditingController shortAnswerController = TextEditingController();
  Map<int, dynamic> answers = {}; // لتخزين كل الإجابات محليًا

  // جلب الأسئلة
  void getQuestions(String examId) async {
    emit(LoadingState(loadingMessage: 'جارى التحميل'));
    var either = await examsRepository.getQuestions(examId);
    either.fold(
          (l) => emit(ErrorState(errorMessage: l.error?.message)),
          (success) {
        questions = success.data?.questions ?? [];
        print("📘 Questions Response: ${success.data?.toJson()}");

        currentQuestionIndex = 0;
        selectedAnswerIndex = null;
        shortAnswerController.clear();
        answers.clear();
        emit(QuestionsSuccessState(questions: questions));
      },
    );
  }

  // اختيار إجابة MCQ
  void selectAnswer(int index) {
    selectedAnswerIndex = index;
    answers[currentQuestionIndex] = index; // 🟢 نخزن كـ int
    emit(QuestionUpdatedState(
      currentIndex: currentQuestionIndex,
      selectedAnswerIndex: selectedAnswerIndex,
      shortAnswer: shortAnswerController.text,
    ));
  }

  // إجابة نصية
  void setShortAnswer(String text) {
    answers[currentQuestionIndex] = text;
    emit(QuestionUpdatedState(
      currentIndex: currentQuestionIndex,
      selectedAnswerIndex: selectedAnswerIndex,
      shortAnswer: text,
    ));
  }




  // التالي
  void goToNextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
      _restoreSavedAnswer();
      emit(QuestionUpdatedState(
        currentIndex: currentQuestionIndex,
        selectedAnswerIndex: selectedAnswerIndex,
        shortAnswer: shortAnswerController.text,
      ));
    } else {
      emit(ExamFinishedState());
    }
  }

  // السابق
  void goToPreviousQuestion() {
    if (currentQuestionIndex > 0) {
      currentQuestionIndex--;
      _restoreSavedAnswer();
      emit(QuestionUpdatedState(
        currentIndex: currentQuestionIndex,
        selectedAnswerIndex: selectedAnswerIndex,
        shortAnswer: shortAnswerController.text,
      ));
    }
  }

  // استعادة إجابة محفوظة
  void _restoreSavedAnswer() {
    if (answers.containsKey(currentQuestionIndex)) {
      var saved = answers[currentQuestionIndex];
      if (saved is int) {
        selectedAnswerIndex = saved;
        shortAnswerController.clear();
      } else if (saved is String) {
        selectedAnswerIndex = null;
        shortAnswerController.text = saved;
      }
    } else {
      selectedAnswerIndex = null;
      shortAnswerController.clear();
    }
  }

  // 🟢 تجهيز الإجابة حسب نوعها (MCQ → نص / ShortAnswer → نص)
  String _prepareAnswerForBackend(int questionIndex) {
    var saved = answers[questionIndex];
    var currentQuestion = questions[questionIndex];

    // ✅ لو السؤال اختيارات (MCQ)
    if (saved is int) {
      // تأكدي إن choices موجودة والطول كافي
      if (currentQuestion.choices != null && saved < currentQuestion.choices!.length) {
        // يرجع نص الاختيار
        return currentQuestion.choices![saved].text ?? "";
      }
    }

    // ✅ لو السؤال إجابة نصية (Short Answer)
    if (saved is String) {
      return saved;
    }

    return "";
  }


  // حفظ الإجابة على السيرفر
  Future<void> saveAnswer(
      String attemptId,
      String questionId,
  String examId,

          { VoidCallback? onSuccess}
      ) async {
    emit(LoadingState(loadingMessage: 'جارى التحميل'));

    // 🟢 تجهيز الإجابة قبل الباك
    String answerToSend = _prepareAnswerForBackend(currentQuestionIndex);

    var either = await examsRepository.saveAnswers(
      attemptId,
      questionId,
      answerToSend,
      examId
    );
    either.fold(
          (l) => emit(ErrorState(errorMessage: l.error?.message)),
          (response) {
        emit(SaveAnswerSuccessState(attempt: response.data?.attempt));
        if (onSuccess != null) onSuccess();
      },
    );
  }

  // void getExams() async {
  //   emit(LoadingState(loadingMessage: 'جارى التحميل'));
  //   var either = await examsRepository.getExams();
  //   either.fold(
  //         (l) => emit(ErrorState(errorMessage: l.error?.message)),
  //         (response) {
  //       examsList = response.data?.exams ?? [];
  //       emit(ExamsSuccessState(exams: examsList));
  //     },
  //   );
  // }

  void submitAttempt(String attemptId) async {
    emit(LoadingState(loadingMessage: 'جارى التحميل'));
    var either = await examsRepository.submitAttempt(attemptId);
    either.fold(
          (l) => emit(ErrorState(errorMessage: l.error?.message)),
          (response) {
        emit(SubmitAnswerSuccessState(attempt: response.data!));
      },
    );
  }

  // void getAttempt() async {
  //   emit(LoadingState(loadingMessage: 'جارى التحميل'));
  //   var either = await examsRepository.getAttempt();
  //   var examEither = await examsRepository.getExams();
  //
  //   either.fold(
  //         (l) => emit(ErrorState(errorMessage: l.error?.message)),
  //         (response) {
  //           examsList = response.data?.exams ?? [];
  //
  //           attemptList = response.data?.attempts ?? [];
  //       emit(MyAttemptSuccessState(attempt: attemptList));
  //     },
  //   );
  // }

  void getExamsAndAttempts() async {
    emit(LoadingState(loadingMessage: 'جارى التحميل'));

    final examsEither = await examsRepository.getExams();
    final attemptsEither = await examsRepository.getAttempt();

    // لو فيه Error في أي واحدة
    if (examsEither.isLeft() || attemptsEither.isLeft()) {
      final error = examsEither.isLeft()
          ? examsEither.swap().getOrElse(() => throw Exception()).error?.message
          : attemptsEither.swap().getOrElse(() => throw Exception()).error?.message;

      emit(ErrorState(errorMessage: error ?? "حدث خطأ"));
      return;
    }

    // ✅ لو نجحوا الاتنين
    examsEither.fold((_) {}, (examsRes) {
      attemptsEither.fold((_) {}, (attemptsRes) {
        examsList = examsRes.data?.exams ?? [];
        attemptList = attemptsRes.data?.attempts ?? [];

        emit(ExamsAndAttemptsState(
          exams: examsList,
          attempts: attemptList,
        ));
      });
    });
  }
}



