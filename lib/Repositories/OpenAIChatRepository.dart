import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Response/LoginError.dart';
import 'package:smart_college/Models/Response/openaiChatResponse.dart';
import 'package:smart_college/sources/OpenAIChatDataSource.dart';

class OpenAIChatRepository {
  final OpenAIChatRemoteDataSource remoteDataSource;

  OpenAIChatRepository(this.remoteDataSource);

  Future<Either<LoginError, OpenAIChatResponse>> sendChatMessage(String message) {
    return remoteDataSource.sendChatMessage(message);
  }
}

