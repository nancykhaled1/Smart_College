import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Response/LoginError.dart';
import 'package:smart_college/Models/Response/templateModel.dart';
import 'package:smart_college/services/remote/apiManager.dart';

class TemplateRemoteDataSource {
  final ApiManager apiManager;

  TemplateRemoteDataSource(this.apiManager);

  Future<Either<LoginError, TemplateResponse>> getTemplates() async {
    return await apiManager.getTemplates();
  }

  Future<Either<LoginError, TemplateDetailResponse>> getTemplateById(String id) async {
    return await apiManager.getTemplateById(id);
  }
}

