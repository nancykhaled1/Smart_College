/// name : "nancy "
/// email : "nancykhaledn90@gmail.com"
/// password : "123456"
/// role : "Graduated"
/// graduatedData : {"cv":"link-to-cv.pdf","employment_status":"Employed","job_title":"Software Engineer","company_location":"Cairo, Egypt","company_email":"company@example.com","company_link":"https://company.com","company_phone":"0123456789","about_company":"Tech company specializing in web apps"}

class AlumniRegisterRequest {
  AlumniRegisterRequest({
      this.name,
      this.email,
      this.password,
      this.role,
      this.graduatedData,});

  AlumniRegisterRequest.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
    graduatedData = json['graduatedData'] != null ? GraduatedData.fromJson(json['graduatedData']) : null;
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

/// cv : "link-to-cv.pdf"
/// employment_status : "Employed"
/// job_title : "Software Engineer"
/// company_location : "Cairo, Egypt"
/// company_email : "company@example.com"
/// company_link : "https://company.com"
/// company_phone : "0123456789"
/// about_company : "Tech company specializing in web apps"

class GraduatedData {
  GraduatedData({
      this.cv,
      this.employmentStatus,
      this.jobTitle,
      this.companyLocation,
      this.companyEmail,
      this.companyLink,
      this.companyPhone,
      this.aboutCompany,});

  GraduatedData.fromJson(dynamic json) {
    cv = json['cv'];
    employmentStatus = json['employment_status'];
    jobTitle = json['job_title'];
    companyLocation = json['company_location'];
    companyEmail = json['company_email'];
    companyLink = json['company_link'];
    companyPhone = json['company_phone'];
    aboutCompany = json['about_company'];
  }
  String? cv;
  String? employmentStatus;
  String? jobTitle;
  String? companyLocation;
  String? companyEmail;
  String? companyLink;
  String? companyPhone;
  String? aboutCompany;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cv'] = cv;
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