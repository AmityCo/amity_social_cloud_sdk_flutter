import 'dart:io' if (dart.library.html) 'dart:html';

/// [UploadFileRequest]
class UploadFileRequest {
  /// init [UploadFileRequest]
  UploadFileRequest({
    required this.files,
    this.feedtype,
    this.fullImage = false,
    this.uploadId,
  });

  /// files
  final List<File> files;

  /// fullimages
  bool fullImage;

  /// upload ID
  String? uploadId;

  /// feedtype ID
  String? feedtype;

  /// To Json
  Map<String, dynamic> toJson() => {
        "fullImage": fullImage,
        "uploadId": uploadId,
        "feedtype": feedtype,
      }..removeWhere((key, value) => value == null);
}
