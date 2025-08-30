class GoogleResponse {
  final bool success;
  final String? token;
  final String? message;
  final UserData? user;

  GoogleResponse({
    required this.success,
    this.token,
    this.message,
    this.user,
  });

  factory GoogleResponse.fromJson(Map<String, dynamic> json) {
    return GoogleResponse(
      success: json["success"],
      token: json["token"],
      message: json["message"],
      user: json["user"] != null ? UserData.fromJson(json["user"]) : null,
    );
  }
}

class UserData {
  final String id;
  final String name;
  final String email;

  UserData({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json["id"],
      name: json["name"],
      email: json["email"],
    );
  }
}
