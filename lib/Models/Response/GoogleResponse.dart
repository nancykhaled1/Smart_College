class GoogleResponse {
  final bool success;
  final String token;
  final String role;
  final bool isNew;
  final UserData user;


  GoogleResponse({
    required this.success,
    required this.token,
    required this.user,
    required this.role,
    required this.isNew,
  });

  factory GoogleResponse.fromJson(Map<String, dynamic> json) {
    return GoogleResponse(
      success: json["success"],
      token: json["token"],
      role: json["role"],
      isNew: json["isNew"],
      user: UserData.fromJson(json['user'] ?? {}),
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
    // required this.role,

  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json["id"]??'',
      name: json["name"]??'',
      email: json["email"],
      // role: json["role"],

    );
  }
}
