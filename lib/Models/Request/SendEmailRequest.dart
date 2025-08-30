/// email : "nancykhaledn905@gmail.com"

class SendEmailRequest {
  SendEmailRequest({
      this.email,});

  SendEmailRequest.fromJson(dynamic json) {
    email = json['email'];
  }
  String? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    return map;
  }

}