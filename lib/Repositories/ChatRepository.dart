import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Response/AllMessagesResponse.dart';
import 'package:smart_college/Models/Response/LoginError.dart';
import 'package:smart_college/sources/ChatDataSource.dart';


class ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepository(this.remoteDataSource);

  // Future<Either<LoginError, SendMessageResponse>> sendMessage(String adminId , String userId , String text,) {
  //   return remoteDataSource.sendMessage(adminId, userId, text);
  // }
  //
  Future<Either<LoginError, AllMessagesResponse>> getMessages() {
    return remoteDataSource.getMessages();
  }
  //
  // Future<Either<LoginError, DeleteMessageResponse>> deleteMessage(String msgId) {
  //   return remoteDataSource.deleteMessage(msgId);
  // }


}