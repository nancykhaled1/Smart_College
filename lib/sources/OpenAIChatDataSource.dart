import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Response/LoginError.dart';
import 'package:smart_college/Models/Response/openaiChatResponse.dart';
import 'package:smart_college/services/remote/apiManager.dart';

class OpenAIChatRemoteDataSource {
  final ApiManager apiManager;

  OpenAIChatRemoteDataSource(this.apiManager);

  Future<Either<LoginError, OpenAIChatResponse>> sendChatMessage(String message) async {
    return await apiManager.openAIChat(message);
  }
}

