// To parse this JSON data, do
//
//     final reactionRequest = reactionRequestFromJson(jsonString);

import 'dart:io';

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
