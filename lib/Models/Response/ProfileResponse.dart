/// success : true
/// data : {"user":{"_id":"68ff606cd4134a7c8a126964","name":"nancyy","email":"nancykhaledhendawy@gmail.com","BaseImage64":null,"isVerified":true,"role":"Graduated","isNew":false,"isOnline":false,"lastSeen":"2025-10-27T12:07:08.253Z","updatedAt":"2025-10-27T12:07:57.113Z","__v":0,"graduatedData":{"_id":"68ff606cd4134a7c8a126966","cv":"Nancy khaled (Flutter Developer) (2).pdf","employment_status":"Postgraduate Studies","job_title":"N/A","company_location":"N/A","company_email":null,"company_link":"N/A","company_phone":null,"about_company":null,"createdAt":"2025-10-27T12:07:08.510Z","updatedAt":"2025-10-28T19:31:37.593Z"}}}

class ProfileResponse {
  ProfileResponse({
      this.success, 
      this.data,});

  ProfileResponse.fromJson(dynamic json) {
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

/// user : {"_id":"68ff606cd4134a7c8a126964","name":"nancyy","email":"nancykhaledhendawy@gmail.com","BaseImage64":null,"isVerified":true,"role":"Graduated","isNew":false,"isOnline":false,"lastSeen":"2025-10-27T12:07:08.253Z","updatedAt":"2025-10-27T12:07:57.113Z","__v":0,"graduatedData":{"_id":"68ff606cd4134a7c8a126966","cv":"Nancy khaled (Flutter Developer) (2).pdf","employment_status":"Postgraduate Studies","job_title":"N/A","company_location":"N/A","company_email":null,"company_link":"N/A","company_phone":null,"about_company":null,"createdAt":"2025-10-27T12:07:08.510Z","updatedAt":"2025-10-28T19:31:37.593Z"}}

class Data {
  Data({
      this.user,});

  Data.fromJson(dynamic json) {
    user = json['user'] != null ? ProfileUser.fromJson(json['user']) : null;
  }
  ProfileUser? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}

/// _id : "68ff606cd4134a7c8a126964"
/// name : "nancyy"
/// email : "nancykhaledhendawy@gmail.com"
/// BaseImage64 : null
/// isVerified : true
/// role : "Graduated"
/// isNew : false
/// isOnline : false
/// lastSeen : "2025-10-27T12:07:08.253Z"
/// updatedAt : "2025-10-27T12:07:57.113Z"
/// __v : 0
/// graduatedData : {"_id":"68ff606cd4134a7c8a126966","cv":"Nancy khaled (Flutter Developer) (2).pdf","employment_status":"Postgraduate Studies","job_title":"N/A","company_location":"N/A","company_email":null,"company_link":"N/A","company_phone":null,"about_company":null,"createdAt":"2025-10-27T12:07:08.510Z","updatedAt":"2025-10-28T19:31:37.593Z"}

class ProfileUser {
  ProfileUser({
      this.id, 
      this.name, 
      this.email, 
      this.baseImage64, 
      this.isVerified, 
      this.role,
    this.level,
     this.department,
      this.isNew, 
      this.isOnline, 
      this.lastSeen, 
      this.updatedAt, 
      this.v, 
      this.graduatedData,});

  ProfileUser.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    baseImage64 = json['BaseImage64'];
    isVerified = json['isVerified'];
    role = json['role'];
    level = json['level'];
    department = json['department'];
    isNew = json['isNew'];
    isOnline = json['isOnline'];
    lastSeen = json['lastSeen'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    graduatedData = json['graduatedData'] != null ? ProfileGraduated.fromJson(json['graduatedData']) : null;
  }
  String? id;
  String? name;
  String? email;
  dynamic baseImage64;
  bool? isVerified;
  String? role;
  int? level;
  String? department;
  bool? isNew;
  bool? isOnline;
  String? lastSeen;
  String? updatedAt;
  int? v;
  ProfileGraduated? graduatedData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['BaseImage64'] = baseImage64;
    map['isVerified'] = isVerified;
    map['role'] = role;
    map['level'] = level;
    map['department'] = department;
    map['isNew'] = isNew;
    map['isOnline'] = isOnline;
    map['lastSeen'] = lastSeen;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    if (graduatedData != null) {
      map['graduatedData'] = graduatedData?.toJson();
    }
    return map;
  }

}

/// _id : "68ff606cd4134a7c8a126966"
/// cv : "Nancy khaled (Flutter Developer) (2).pdf"
/// employment_status : "Postgraduate Studies"
/// job_title : "N/A"
/// company_location : "N/A"
/// company_email : null
/// company_link : "N/A"
/// company_phone : null
/// about_company : null
/// createdAt : "2025-10-27T12:07:08.510Z"
/// updatedAt : "2025-10-28T19:31:37.593Z"

class ProfileGraduated {
  ProfileGraduated({
      this.id, 
      this.cv, 
      this.employmentStatus, 
      this.jobTitle, 
      this.companyLocation, 
      this.companyEmail, 
      this.companyLink, 
      this.companyPhone, 
      this.aboutCompany, 
      this.createdAt, 
      this.updatedAt,});

  ProfileGraduated.fromJson(dynamic json) {
    id = json['_id'];
    cv = json['cv'];
    employmentStatus = json['employment_status'];
    jobTitle = json['job_title'];
    companyLocation = json['company_location'];
    companyEmail = json['company_email'];
    companyLink = json['company_link'];
    companyPhone = json['company_phone'];
    aboutCompany = json['about_company'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  String? id;
  String? cv;
  String? employmentStatus;
  String? jobTitle;
  String? companyLocation;
  dynamic companyEmail;
  String? companyLink;
  dynamic companyPhone;
  dynamic aboutCompany;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['cv'] = cv;
    map['employment_status'] = employmentStatus;
    map['job_title'] = jobTitle;
    map['company_location'] = companyLocation;
    map['company_email'] = companyEmail;
    map['company_link'] = companyLink;
    map['company_phone'] = companyPhone;
    map['about_company'] = aboutCompany;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }

}