// To parse this JSON data, do
//
//     final attachmentResponse = attachmentResponseFromJson(jsonString);

import 'dart:convert';

AttachmentResponse attachmentResponseFromJson(String str) => AttachmentResponse.fromJson(json.decode(str));

String attachmentResponseToJson(AttachmentResponse data) => json.encode(data.toJson());

class AttachmentResponse {
  String type;
  String fileId;

  AttachmentResponse({
    required this.type,
    required this.fileId,
  });

  AttachmentResponse copyWith({
    String? type,
    String? fileId,
  }) =>
      AttachmentResponse(
        type: type ?? this.type,
        fileId: fileId ?? this.fileId,
      );

  factory AttachmentResponse.fromJson(Map<String, dynamic> json) => AttachmentResponse(
        type: json["type"],
        fileId: json["fileId"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "fileId": fileId,
      };
}
