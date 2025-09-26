/// level : "1"
/// department : "CS"

class CompleteProfileRequest {
  CompleteProfileRequest({
      this.level = "",
      this.department="",});

  String level;
  String department;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['level'] = level ;
    map['department'] = department;
    return map;
  }

}