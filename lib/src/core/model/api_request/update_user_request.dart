// To parse this JSON data, do
//
//     final updateUserRequest = updateUserRequestFromJson(jsonString);

import 'dart:convert';

UpdateUserRequest updateUserRequestFromJson(String str) =>
    UpdateUserRequest.fromJson(json.decode(str));

String updateUserRequestToJson(UpdateUserRequest data) =>
    json.encode(data.toJson());

class UpdateUserRequest {
  UpdateUserRequest({
    this.userId,
    this.displayName,
    this.roles,
    this.metadata,
    this.avatarFileId,
    this.avatarCustomUrl,
    this.description,
  });

  String? userId;
  String? displayName;
  List<String>? roles;
  Map<String, dynamic>? metadata;
  String? avatarFileId;
  String? avatarCustomUrl;
  String? description;

  factory UpdateUserRequest.fromJson(Map<String, dynamic> json) =>
      UpdateUserRequest(
        userId: json["userId"],
        displayName: json["displayName"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        metadata: json["metadata"],
        avatarFileId: json["avatarFileId"],
        avatarCustomUrl: json["avatarCustomUrl"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "displayName": displayName,
        "roles":
            roles == null ? null : List<dynamic>.from(roles!.map((x) => x)),
        "metadata": metadata,
        "avatarFileId": avatarFileId,
        "avatarCustomUrl": avatarCustomUrl,
        "description": description,
      };
}
