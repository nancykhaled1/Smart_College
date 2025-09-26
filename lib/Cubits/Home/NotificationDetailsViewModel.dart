

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_college/Cubits/States/States.dart';
import 'package:smart_college/Repositories/CounterRepository.dart';
import 'package:smart_college/Repositories/GetNotificationRepository.dart';
import 'package:smart_college/Repositories/NotificationDetailsRepository.dart';

import '../../Models/Response/GetNotificationResponse.dart';

class NotificationDetailsViewModel extends Cubit<States> {
  final NotificationDetailsRepository notificationDetailsRepository;
  final CounterRepository counterRepository;

  NotificationDetailsViewModel( this.notificationDetailsRepository, this.counterRepository)
      : super(InitialState());






  void getNotificationDetails(String notificationId) async {
    emit(LoadingState(loadingMessage: 'جارى التحميل')); // ⬅️ عشان يمسح القديم ويعرض loader

    var either = await notificationDetailsRepository.getNotification(notificationId);
    either.fold(
          (l) {
        emit(ErrorState(errorMessage: l.error?.message));
      },
          (success) {
        emit(NotificationDetailsSuccessState(notificationDetails: success.data!));
        }

    );
  }


  void getCounter() async {
    emit(LoadingState(loadingMessage: 'جارى التحميل')); // ⬅️ عشان يمسح القديم ويعرض loader

    var either = await counterRepository.getCounter();
    either.fold(
            (l) {
          emit(ErrorState(errorMessage: l.error?.message));
        },
            (success) {
          emit(CounterSuccessState(counterData: success.data!));
        }

    );
  }



}
