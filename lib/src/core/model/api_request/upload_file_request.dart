import 'dart:io' if (dart.library.html) 'dart:html';

class UploadFileRequest {
  UploadFileRequest({
    this.fullImage = false,
    this.uploadId,
  });

  List<File> files = [];
  bool fullImage;
  String? uploadId;

  Map<String, dynamic> toJson() => {
        "fullImage": fullImage,
        "uploadId": uploadId,
      }..removeWhere((key, value) => value == null);
}
