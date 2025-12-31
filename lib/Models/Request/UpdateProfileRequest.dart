import 'dart:io';

/// name : "Hassan"
/// level : 4

class UpdateProfileRequest {
  UpdateProfileRequest({
      this.name, 
      this.level,
    this.email,
    this.department,
    this.graduatedData
  });

  String? name;
  int? level;
  String? department;
  String? email;
  GraduatedData? graduatedData;




  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['level'] = level;
    map['department'] = department;
    map['email'] = email;
    if (graduatedData != null) {
      map['graduatedData'] = graduatedData?.toJson();
    }

    return map;
  }


}

class GraduatedData {
  GraduatedData({
    this.cv,
    this.employmentStatus,
    this.jobTitle,
    this.companyLocation,
    this.companyEmail,
    this.companyLink,
    this.companyPhone,
    this.aboutCompany,
});

  dynamic  cv;
  String? employmentStatus;
  String? jobTitle;
  String? companyLocation;
  String? companyEmail;
  String? companyLink;
  String? companyPhone;
  String? aboutCompany;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (cv != null) {
      if (cv is File) {
        map['cv'] = cv!.path.split('/').last;
      } else if (cv is String) {
        map['cv'] = cv; // 🔹 لو لينك جاهز من السيرفر
      }
    }
    map['employment_status'] = employmentStatus;
    map['job_title'] = jobTitle;
    map['company_location'] = companyLocation;
    map['company_email'] = companyEmail;
    map['company_link'] = companyLink;
    map['company_phone'] = companyPhone;
    map['about_company'] = aboutCompany;
    return map;
  }

}