class StudentRegisterRequest {
  StudentRegisterRequest({
    this.name = "",
    this.email = "",
    this.password = "",
    this.role = "",
    this.level = "",
    this.department = "",
  });

  String name;
  String email;
  String password;
  String role;
  String level;
  String department;


  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "role": role,
      "level": level,
      "department": department,

    };
  }
}
