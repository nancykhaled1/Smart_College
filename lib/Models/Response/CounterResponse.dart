/// success : true
/// data : {"unreadCount":0}

class CounterResponse {
  CounterResponse({
      this.success, 
      this.data,});

  CounterResponse.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? CounterData.fromJson(json['data']) : null;
  }
  bool? success;
  CounterData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// unreadCount : 0

class CounterData {
  CounterData({
      this.unreadCount,});

  CounterData.fromJson(dynamic json) {
    unreadCount = json['unreadCount'];
  }
  int? unreadCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unreadCount'] = unreadCount;
    return map;
  }

}