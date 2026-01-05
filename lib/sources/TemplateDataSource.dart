import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
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

  Future<Either<LoginError, TemplateResponse>> searchTemplates(String query) async {
    return await apiManager.searchTemplates(query);
  }
}


 