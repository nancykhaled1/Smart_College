class VideoModel {
  final String name;
  final String url;
  final int duration;
  final String quality;
  final DateTime uploadDate;

  VideoModel({
    required this.name,
    required this.url,
    required this.duration,
    required this.quality,
    required this.uploadDate,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      name: json['name'] ?? '',
      url: json['url'] ?? '',
      duration: json['duration'] ?? 0,
      quality: json['quality'] ?? '',
      uploadDate: DateTime.parse(json['uploadDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
      'duration': duration,
      'quality': quality,
      'uploadDate': uploadDate.toIso8601String(),
    };
  }
}

// 2. PDF Model
class PdfModel {
  final String id;
  final String name;
  final String url;
  final DateTime uploadDate;

  PdfModel({
    required this.id,
    required this.name,
    required this.url,
    required this.uploadDate,
  });

  factory PdfModel.fromJson(Map<String, dynamic> json) {
    return PdfModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      url: json['url'] ?? '',
      uploadDate: DateTime.parse(json['uploadDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'url': url,
      'uploadDate': uploadDate.toIso8601String(),
    };
  }
}

// 3. Lecture Model
class LectureModel {
  final String id;
  final String subName;
  final int numOfWeek;
  final DateTime date;
  final VideoModel video;
  final List<PdfModel> pdfs;

  LectureModel({
    required this.id,
    required this.subName,
    required this.numOfWeek,
    required this.date,
    required this.video,
    required this.pdfs,
  });

  factory LectureModel.fromJson(Map<String, dynamic> json) {
    return LectureModel(
      id: json['_id'] ?? '',
      subName: json['sub_name'] ?? '',
      numOfWeek: json['num_of_week'] ?? 0,
      date: DateTime.parse(json['createdAt']),
      video: VideoModel.fromJson(json['video']),
      pdfs: (json['pdfs'] as List)
          .map((pdf) => PdfModel.fromJson(pdf))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'sub_name': subName,
      'num_of_week': numOfWeek,
      'createdAt': date.toIso8601String(),
      'video': video.toJson(),
      'pdfs': pdfs.map((pdf) => pdf.toJson()).toList(),
    };
  }
}

// 4. Response Model
class LectureResponseModel {
  final bool success;
  final List<LectureModel> data;

  LectureResponseModel({
    required this.success,
    required this.data,
  });

  factory LectureResponseModel.fromJson(Map<String, dynamic> json) {
    return LectureResponseModel(
      success: json['success'] ?? false,
      data: (json['data'] as List)
          .map((lecture) => LectureModel.fromJson(lecture))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.map((lecture) => lecture.toJson()).toList(),
    };
  }
  
}
class LectureDetailResponse {
  final bool success;
  final LectureModel data;

  LectureDetailResponse({
    required this.success,
    required this.data,
  });

  factory LectureDetailResponse.fromJson(Map<String, dynamic> json) {
    return LectureDetailResponse(
      success: json['success'] ?? false,
      data: LectureModel.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.toJson(),
    };
  }
}