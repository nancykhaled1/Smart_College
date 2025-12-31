import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Response/DeleteProfileResponse.dart';

import 'package:smart_college/Models/Response/LoginError.dart';
import 'package:smart_college/Models/Response/ProfileResponse.dart';
import 'package:smart_college/Models/Response/UpdateProfile.dart';
import '../Models/Request/ImageRequest.dart';
import '../Models/Request/UpdateProfileRequest.dart';
import '../Models/Response/ImageResponse.dart';
import '../services/remote/apiManager.dart';

class ProfileDataSource {
  final ApiManager apiManager;

  ProfileDataSource(this.apiManager);

  Future<Either<LoginError, ProfileResponse>> getProfile() {
    return apiManager.getProfile();
  }

  Future<Either<LoginError, UpdateProfile>> updateData(UpdateProfileRequest request ) {
    return apiManager.updateData(request);
  }

  Future<Either<LoginError, ImageResponse>> uploadProfileImage(ImageRequest request) {
    return apiManager.uploadProfileImage(request);
  }

  Future<Either<LoginError, DeleteProfileResponse>> deleteProfile() {
    return apiManager.deleteProfile();
  }
}