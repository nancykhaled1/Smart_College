import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_college/Cubits/States/States.dart';
import '../../Models/Request/NotificationRequest.dart';
import '../../Repositories/NotificationRepository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../View/Notification/notification_screen.dart' show NotificationScreen;



class NotificationCubit extends Cubit<States> {
  final NotificationRepository repository;
  NotificationCubit(this.repository) : super(InitialState());
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


  void getFcmToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print("FCM Token: $token");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('fcm_token', token ?? '');

  }


  void listenToMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Message received: ${message.notification?.title}");
      // ممكن هنا تعملي emit(NotificationReceivedState(message));
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("App opened from notification: ${message.notification?.title}");
      navigatorKey.currentState?.pushNamed(NotificationScreen.routeName);
    });
  }

  Future<void> sendFcmToken() async {
    emit(LoadingState(loadingMessage: 'Loading..'));

    try {
      // 1- هات الـ token من Firebase
      String? token = await FirebaseMessaging.instance.getToken();

      if (token == null) {
        emit(ErrorState(errorMessage: "Failed to get FCM token"));
        return;
      }

      // 2- ابعت الـ token للباك
      final request = NotificationRequest(token: token);
      final response = await repository.sendNotification(request);

      response.fold(
          (error){
            emit(ErrorState(errorMessage: "Server error: ${error.error?.message}"));
          },
            (response){
      emit(NotificationSuccessState(response: response));
      }
      );
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }
}

