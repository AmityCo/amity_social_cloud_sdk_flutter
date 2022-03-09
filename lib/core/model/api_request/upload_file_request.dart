// To parse this JSON data, do
//
//     final reactionRequest = reactionRequestFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

String reactionRequestToJson(UploadFileRequest data) =>
    json.encode(data.toJson());

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
