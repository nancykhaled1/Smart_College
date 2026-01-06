import 'dart:io';

class AlumniRegisterRequest {
  AlumniRegisterRequest({
    this.name,
    this.email,
    this.password,
    this.role,
    this.graduatedData,
  });

  AlumniRegisterRequest.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
    graduatedData = json['graduatedData'] != null
        ? GraduatedData.fromJson(json['graduatedData'])
        : null;
  }

  String? name;
  String? email;
  String? password;
  String? role;
  GraduatedData? graduatedData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['password'] = password;
    map['role'] = role;
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

  GraduatedData.fromJson(dynamic json) {
    // مفيش تحويل مباشر من String لـ File لأن API بترجع لينك مش فايل
    // فهنا هتسيبها null أو تستخدمها بعد التحميل
    employmentStatus = json['employment_status'];
    jobTitle = json['job_title'];
    companyLocation = json['company_location'];
    companyEmail = json['company_email'];
    companyLink = json['company_link'];
    companyPhone = json['company_phone'];
    aboutCompany = json['about_company'];
  }

  File? cv; // ✅ اتغير النوع هنا
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
      map['cv'] = cv!.path.split('/').last; // بس الاسم أو المسار لو هترفعه Multipart
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
