/// BaseImage64 : "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAA..."

class ImageRequest {
  ImageRequest({
      this.baseImage64,});

  ImageRequest.fromJson(dynamic json) {
    baseImage64 = json['BaseImage64'];
  }
  String? baseImage64;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['BaseImage64'] = baseImage64;
    return map;
  }

}