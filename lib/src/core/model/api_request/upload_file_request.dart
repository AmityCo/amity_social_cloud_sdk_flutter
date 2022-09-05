import 'dart:io' if (dart.library.html) 'dart:html';

/// [UploadFileRequest]
class UploadFileRequest {
  /// init [UploadFileRequest]
  UploadFileRequest({
    this.fullImage = false,
    this.uploadId,
  });

  /// files
  List<File> files = [];

  /// fullimages
  bool fullImage;

  /// upload ID
  String? uploadId;

  /// To Json
  Map<String, dynamic> toJson() => {
        "fullImage": fullImage,
        "uploadId": uploadId,
      }..removeWhere((key, value) => value == null);
}
