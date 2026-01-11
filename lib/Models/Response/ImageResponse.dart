/// success : true
/// data : {"message":"Profile image updated successfully","imageUrl":"http://smartcollgeapp-production.up.railway.app/uploads/profile_images/68ca7ac4604923e139462899.png"}

class ImageResponse {
  ImageResponse({
      this.success, 
      this.data,});

  ImageResponse.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// message : "Profile image updated successfully"
/// imageUrl : "http://smartcollgeapp-production.up.railway.app/uploads/profile_images/68ca7ac4604923e139462899.png"

class Data {
  Data({
      this.message, 
      this.imageUrl,});

  Data.fromJson(dynamic json) {
    message = json['message'];
    imageUrl = json['imageUrl'];
  }
  String? message;
  String? imageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['imageUrl'] = imageUrl;
    return map;
  }

}