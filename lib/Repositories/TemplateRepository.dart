import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Response/LoginError.dart';
import 'package:smart_college/Models/Response/templateModel.dart';
import 'package:smart_college/sources/TemplateDataSource.dart';

class TemplateRepository {
  final TemplateRemoteDataSource remoteDataSource;

  TemplateRepository(this.remoteDataSource);

  Future<Either<LoginError, TemplateResponse>> getTemplates() {
    return remoteDataSource.getTemplates();
  }

  Future<Either<LoginError, TemplateDetailResponse>> getTemplateById(String id) {
    return remoteDataSource.getTemplateById(id);
  }

  Future<Either<LoginError, TemplateResponse>> searchTemplates(String query) {
    return remoteDataSource.searchTemplates(query);
  }
}

