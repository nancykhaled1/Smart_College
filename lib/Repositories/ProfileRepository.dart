import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Response/DeleteProfileResponse.dart';
import 'package:smart_college/Models/Response/LoginError.dart';
import 'package:smart_college/Models/Response/ProfileResponse.dart';
import 'package:smart_college/Models/Response/UpdateProfile.dart';
import 'package:smart_college/sources/ProfileDataSource.dart';

import '../Models/Request/ImageRequest.dart';
import '../Models/Request/UpdateProfileRequest.dart';
import '../Models/Response/ImageResponse.dart';

class ProfileRepository {
  final ProfileDataSource remoteDataSource;

  ProfileRepository(this.remoteDataSource);

  Future<Either<LoginError, ProfileResponse>> getProfile() {
    return remoteDataSource.getProfile();
  }

  Future<Either<LoginError, UpdateProfile>> updateData(UpdateProfileRequest request ) {
    return remoteDataSource.updateData(request);
  }


  Future<Either<LoginError, ImageResponse>> uploadProfileImage(ImageRequest request) {
    return remoteDataSource.uploadProfileImage(request);
  }

  Future<Either<LoginError, DeleteProfileResponse>> deleteProfile() {
    return remoteDataSource.deleteProfile();
  }
}





