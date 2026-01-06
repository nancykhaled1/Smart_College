/// success : true
/// data : {"message":"Profile updated successfully","user":{"_id":"68f7ea71ffcca80ce9c8fbcf","name":"Hossam Ali","email":"nancykhaledn905@gmail.com","role":"Graduated","BaseImage64":null,"graduatedData":{"_id":"68f7ea72ffcca80ce9c8fbd1","user":"68f7ea71ffcca80ce9c8fbcf","cv":"Nancy khaled (Flutter Developer) (2).pdf","employment_status":"Freelancer","job_title":"Flutter Developer","company_location":"Cairo","company_email":"N/A","company_link":"https://flutter.com","company_phone":"N/A","about_company":"Remote software agency","createdAt":"2025-10-21T20:17:54.112Z","updatedAt":"2025-10-27T12:23:31.333Z","__v":0}}}

class UpdateProfile {
  UpdateProfile({
      this.success, 
      this.data,});

  UpdateProfile.fromJson(dynamic json) {
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

/// message : "Profile updated successfully"
/// user : {"_id":"68f7ea71ffcca80ce9c8fbcf","name":"Hossam Ali","email":"nancykhaledn905@gmail.com","role":"Graduated","BaseImage64":null,"graduatedData":{"_id":"68f7ea72ffcca80ce9c8fbd1","user":"68f7ea71ffcca80ce9c8fbcf","cv":"Nancy khaled (Flutter Developer) (2).pdf","employment_status":"Freelancer","job_title":"Flutter Developer","company_location":"Cairo","company_email":"N/A","company_link":"https://flutter.com","company_phone":"N/A","about_company":"Remote software agency","createdAt":"2025-10-21T20:17:54.112Z","updatedAt":"2025-10-27T12:23:31.333Z","__v":0}}

class Data {
  Data({
      this.message, 
      this.user,});

  Data.fromJson(dynamic json) {
    message = json['message'];
    user = json['user'] != null ? UserUpdate.fromJson(json['user']) : null;
  }
  String? message;
  UserUpdate? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}

/// _id : "68f7ea71ffcca80ce9c8fbcf"
/// name : "Hossam Ali"
/// email : "nancykhaledn905@gmail.com"
/// role : "Graduated"
/// BaseImage64 : null
/// graduatedData : {"_id":"68f7ea72ffcca80ce9c8fbd1","user":"68f7ea71ffcca80ce9c8fbcf","cv":"Nancy khaled (Flutter Developer) (2).pdf","employment_status":"Freelancer","job_title":"Flutter Developer","company_location":"Cairo","company_email":"N/A","company_link":"https://flutter.com","company_phone":"N/A","about_company":"Remote software agency","createdAt":"2025-10-21T20:17:54.112Z","updatedAt":"2025-10-27T12:23:31.333Z","__v":0}

class UserUpdate {
  UserUpdate({
      this.id, 
      this.name, 
      this.email, 
      this.role, 
      this.baseImage64, 
      this.graduatedData,});

  UserUpdate.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    baseImage64 = json['BaseImage64'];
    graduatedData = json['graduatedData'] != null ? GraduatedData.fromJson(json['graduatedData']) : null;
  }
  String? id;
  String? name;
  String? email;
  String? role;
  dynamic baseImage64;
  GraduatedData? graduatedData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['role'] = role;
    map['BaseImage64'] = baseImage64;
    if (graduatedData != null) {
      map['graduatedData'] = graduatedData?.toJson();
    }
    return map;
  }

}

/// _id : "68f7ea72ffcca80ce9c8fbd1"
/// user : "68f7ea71ffcca80ce9c8fbcf"
/// cv : "Nancy khaled (Flutter Developer) (2).pdf"
/// employment_status : "Freelancer"
/// job_title : "Flutter Developer"
/// company_location : "Cairo"
/// company_email : "N/A"
/// company_link : "https://flutter.com"
/// company_phone : "N/A"
/// about_company : "Remote software agency"
/// createdAt : "2025-10-21T20:17:54.112Z"
/// updatedAt : "2025-10-27T12:23:31.333Z"
/// __v : 0

class GraduatedData {
  GraduatedData({
      this.id, 
      this.user, 
      this.cv, 
      this.employmentStatus, 
      this.jobTitle, 
      this.companyLocation, 
      this.companyEmail, 
      this.companyLink, 
      this.companyPhone, 
      this.aboutCompany, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  GraduatedData.fromJson(dynamic json) {
    id = json['_id'];
    user = json['user'];
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
    v = json['__v'];
  }
  String? id;
  String? user;
  String? cv;
  String? employmentStatus;
  String? jobTitle;
  String? companyLocation;
  String? companyEmail;
  String? companyLink;
  String? companyPhone;
  String? aboutCompany;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['user'] = user;
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
    map['__v'] = v;
    return map;
  }

}