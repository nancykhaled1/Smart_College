import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_college/Cubits/States/States.dart';
import 'package:smart_college/Repositories/GetNotificationRepository.dart';

import '../../Models/Response/GetNotificationResponse.dart';

class NotificationScreenViewModel extends Cubit<States> {
 final GetNotificationRepository getNotificationRepository;
  NotificationScreenViewModel( this.getNotificationRepository)
      : super(InitialState());

 List<NotificationData> notifications = [];



 void getNotification() async {
    emit(LoadingState(loadingMessage: 'Loading...'));
    var either = await getNotificationRepository.getNotification();
    either.fold(
          (l) {
        emit(ErrorState(errorMessage: l.error?.message));
      },

                (response) {
                  notifications = response.data ?? [];
                  emit(GetNotificationSuccessState(notifications: notifications));
                },

    );
  }


}
