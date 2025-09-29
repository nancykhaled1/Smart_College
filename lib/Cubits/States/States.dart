import 'package:smart_college/Models/Response/ChangePaswwordResponse.dart';
import 'package:smart_college/Models/Response/CounterResponse.dart';
import 'package:smart_college/Models/Response/ExamDetailsResponse.dart';
import 'package:smart_college/Models/Response/ExamsResponse.dart';
import 'package:smart_college/Models/Response/GoogleResponse.dart';
import 'package:smart_college/Models/Response/LoginResponse.dart';
import 'package:smart_college/Models/Response/NotificationDetailsResponse.dart';
import 'package:smart_college/Models/Response/NotificationResponse.dart';
import 'package:smart_college/Models/Response/ResetPasswordResponse.dart';
import 'package:smart_college/Models/Response/SendEmailResponse.dart';
import '../../Models/Response/AllMessagesResponse.dart';
import '../../Models/Response/GetNotificationResponse.dart';
import '../../Models/Response/QuestionsResponse.dart';
import '../../Models/Response/StartAttemptsResponse.dart';

abstract class States{}

class InitialState extends States{}

class LoadingState extends States{
  String? loadingMessage;
  LoadingState({required this.loadingMessage});
}

class ErrorState extends States{
  String? errorMessage;
  ErrorState({required this.errorMessage});
}

class LoginSuccessState extends States {
  final LoginResponse response;

  LoginSuccessState({required this.response});
}

class SendEmailSuccessState extends States {
  final SendEmailResponse response;

  SendEmailSuccessState({required this.response});
}

class ResetPassSuccessState extends States {
  final ResetPasswordResponse response;

  ResetPassSuccessState({required this.response});
}

class ChangePassSuccessState extends States {
  final ChangePaswwordResponse response;

  ChangePassSuccessState({required this.response});
}

class GoogleSuccessState extends States {
  final GoogleResponse response;

  GoogleSuccessState({required this.response});
}

class NotificationSuccessState extends States {
  final NotificationResponse response;

  NotificationSuccessState({required this.response});
}

class GetNotificationSuccessState extends States {
  final List<NotificationData> notifications;

  GetNotificationSuccessState({required this.notifications});
}

class NotificationDetailsSuccessState extends States {
  final DataDetails notificationDetails;

  NotificationDetailsSuccessState({required this.notificationDetails});
}

class CounterSuccessState extends States {
  final CounterData counterData;

  CounterSuccessState({required this.counterData});
}

// class SendMessageSuccess extends States {
//   final Message message;
//
//   SendMessageSuccess(this.message);
// }
//
// class UserMessageSuccess extends States {
//   final List<Message> message;
//
//   UserMessageSuccess(this.message);
// }
// 📌 حالات خاصة بالسوكت

class ExamsSuccessState extends States {
  final List<Exams> exams;

  ExamsSuccessState({required this.exams});
}

class ExamDetailsSuccessState extends States {
  final Exam examDetails;

  ExamDetailsSuccessState({required this.examDetails});
}

class QuestionsSuccessState extends States {
  final List<Questions> questions;

  QuestionsSuccessState({required this.questions});
}

class QuestionUpdatedState extends States {
  final int currentIndex;
  final int? selectedAnswerIndex;
  final String shortAnswer;

  QuestionUpdatedState({
    required this.currentIndex,
    this.selectedAnswerIndex,
    this.shortAnswer = "",
  });
}

class ExamFinishedState extends States {}

class StartAttemptSuccessState extends States {
  final dynamic attempt;
  final Duration remaining;
  StartAttemptSuccessState({required this.attempt, required this.remaining});
}

class TimerTickState extends States {
  final Duration remaining;
  TimerTickState({required this.remaining});
}

class TimerFinishedState extends States {}



class GetMessagesSuccessState extends States {
  final List<MessageData> messages;
  GetMessagesSuccessState({required this.messages});
}

class ChatInitial extends States {}

class ChatConnecting extends States {}

class ChatConnected extends States {}

class ChatDisconnected extends States {}

class ChatMessagesLoaded extends States {
  final List messages;
  ChatMessagesLoaded(this.messages);

  @override
  List<Object?> get props => [messages];
}

class ChatTyping extends States {
  final bool isTyping;
  ChatTyping(this.isTyping);

  @override
  List<Object?> get props => [isTyping];
}


class ChatTypingState extends States {
  final List<MessageData> messages;
  final bool isTyping;

  ChatTypingState({required this.messages, required this.isTyping});
}

