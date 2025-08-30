class StudentRegisterRequest {
  StudentRegisterRequest({
    this.name = "",
    this.email = "",
    this.password = "",
    this.role = "",
  });

  String name;
  String email;
  String password;
  String role;


  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "role": role,

    };
  }
}
