// /// success : true
// /// data : {"user":{"_id":"68f7ea71ffcca80ce9c8fbcf","name":"nancy ","email":"nancykhaledn905@gmail.com","BaseImage64":null,"isVerified":true,"role":"Graduated","isNew":false,"isOnline":false,"lastSeen":"2025-10-21T20:17:53.842Z","updatedAt":"2025-10-21T20:18:32.849Z","__v":0},"graduated":{"_id":"68f7ea72ffcca80ce9c8fbd1","user":"68f7ea71ffcca80ce9c8fbcf","cv":"Nancy khaled (Flutter Developer) (2).pdf","employment_status":"Employed","job_title":"flutter Developer ","company_location":"خارج مصر","company_email":"N/A","company_link":"https://flutter.com","company_phone":"N/A","about_company":"N/A","createdAt":"2025-10-21T20:17:54.112Z","updatedAt":"2025-10-21T20:17:54.112Z","__v":0}}
//
// class ProfileResponse {
//   ProfileResponse({
//     this.success,
//     this.data,});
//
//   ProfileResponse.fromJson(dynamic json) {
//     success = json['success'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }
//   bool? success;
//   Data? data;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['success'] = success;
//     if (data != null) {
//       map['data'] = data?.toJson();
//     }
//     return map;
//   }
//
// }
//
// /// user : {"_id":"68f7ea71ffcca80ce9c8fbcf","name":"nancy ","email":"nancykhaledn905@gmail.com","BaseImage64":null,"isVerified":true,"role":"Graduated","isNew":false,"isOnline":false,"lastSeen":"2025-10-21T20:17:53.842Z","updatedAt":"2025-10-21T20:18:32.849Z","__v":0}
// /// graduated : {"_id":"68f7ea72ffcca80ce9c8fbd1","user":"68f7ea71ffcca80ce9c8fbcf","cv":"Nancy khaled (Flutter Developer) (2).pdf","employment_status":"Employed","job_title":"flutter Developer ","company_location":"خارج مصر","company_email":"N/A","company_link":"https://flutter.com","company_phone":"N/A","about_company":"N/A","createdAt":"2025-10-21T20:17:54.112Z","updatedAt":"2025-10-21T20:17:54.112Z","__v":0}
//
// class Data {
//   Data({
//     this.user,
//     this.graduated,});
//
//   Data.fromJson(dynamic json) {
//     user = json['user'] != null ? GradProfile.fromJson(json['user']) : null;
//     graduated = json['graduated'] != null ? Graduated.fromJson(json['graduated']) : null;
//   }
//   GradProfile? user;
//   Graduated? graduated;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (user != null) {
//       map['user'] = user?.toJson();
//     }
//     if (graduated != null) {
//       map['graduated'] = graduated?.toJson();
//     }
//     return map;
//   }
//
// }
//
// /// _id : "68f7ea72ffcca80ce9c8fbd1"
// /// user : "68f7ea71ffcca80ce9c8fbcf"
// /// cv : "Nancy khaled (Flutter Developer) (2).pdf"
// /// employment_status : "Employed"
// /// job_title : "flutter Developer "
// /// company_location : "خارج مصر"
// /// company_email : "N/A"
// /// company_link : "https://flutter.com"
// /// company_phone : "N/A"
// /// about_company : "N/A"
// /// createdAt : "2025-10-21T20:17:54.112Z"
// /// updatedAt : "2025-10-21T20:17:54.112Z"
// /// __v : 0
//
// class Graduated {
//   Graduated({
//     this.id,
//     this.user,
//     this.cv,
//     this.employmentStatus,
//     this.jobTitle,
//     this.companyLocation,
//     this.companyEmail,
//     this.companyLink,
//     this.companyPhone,
//     this.aboutCompany,
//     this.createdAt,
//     this.updatedAt,
//     this.v,});
//
//   Graduated.fromJson(dynamic json) {
//     id = json['_id'];
//     user = json['user'];
//     cv = json['cv'];
//     employmentStatus = json['employment_status'];
//     jobTitle = json['job_title'];
//     companyLocation = json['company_location'];
//     companyEmail = json['company_email'];
//     companyLink = json['company_link'];
//     companyPhone = json['company_phone'];
//     aboutCompany = json['about_company'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     v = json['__v'];
//   }
//   String? id;
//   String? user;
//   String? cv;
//   String? employmentStatus;
//   String? jobTitle;
//   String? companyLocation;
//   String? companyEmail;
//   String? companyLink;
//   String? companyPhone;
//   String? aboutCompany;
//   String? createdAt;
//   String? updatedAt;
//   int? v;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['_id'] = id;
//     map['user'] = user;
//     map['cv'] = cv;
//     map['employment_status'] = employmentStatus;
//     map['job_title'] = jobTitle;
//     map['company_location'] = companyLocation;
//     map['company_email'] = companyEmail;
//     map['company_link'] = companyLink;
//     map['company_phone'] = companyPhone;
//     map['about_company'] = aboutCompany;
//     map['createdAt'] = createdAt;
//     map['updatedAt'] = updatedAt;
//     map['__v'] = v;
//     return map;
//   }
//
// }
//
// /// _id : "68f7ea71ffcca80ce9c8fbcf"
// /// name : "nancy "
// /// email : "nancykhaledn905@gmail.com"
// /// BaseImage64 : null
// /// isVerified : true
// /// role : "Graduated"
// /// isNew : false
// /// isOnline : false
// /// lastSeen : "2025-10-21T20:17:53.842Z"
// /// updatedAt : "2025-10-21T20:18:32.849Z"
// /// __v : 0
//
// class GradProfile {
//   GradProfile({
//     this.id,
//     this.name,
//     this.email,
//     this.baseImage64,
//     this.isVerified,
//     this.role,
//     this.isNew,
//     this.isOnline,
//     this.lastSeen,
//     this.updatedAt,
//     this.v,});
//
//   GradProfile.fromJson(dynamic json) {
//     id = json['_id'];
//     name = json['name'];
//     email = json['email'];
//     baseImage64 = json['BaseImage64'];
//     isVerified = json['isVerified'];
//     role = json['role'];
//     isNew = json['isNew'];
//     isOnline = json['isOnline'];
//     lastSeen = json['lastSeen'];
//     updatedAt = json['updatedAt'];
//     v = json['__v'];
//   }
//   String? id;
//   String? name;
//   String? email;
//   dynamic baseImage64;
//   bool? isVerified;
//   String? role;
//   bool? isNew;
//   bool? isOnline;
//   String? lastSeen;
//   String? updatedAt;
//   int? v;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['_id'] = id;
//     map['name'] = name;
//     map['email'] = email;
//     map['BaseImage64'] = baseImage64;
//     map['isVerified'] = isVerified;
//     map['role'] = role;
//     map['isNew'] = isNew;
//     map['isOnline'] = isOnline;
//     map['lastSeen'] = lastSeen;
//     map['updatedAt'] = updatedAt;
//     map['__v'] = v;
//     return map;
//   }
//
// }