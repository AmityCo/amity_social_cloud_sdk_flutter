import 'dart:convert';

CreateCommunityRequest createPostRequestFromJson(String str) =>
    CreateCommunityRequest.fromJson(json.decode(str));

String createPostRequestToJson(CreateCommunityRequest data) =>
    json.encode(data.toJson());

class CreateCommunityRequest {
  CreateCommunityRequest({
    required this.displayName,
    required this.categoryIds,
    this.description,
    this.isPublic,
    this.metadata,
    this.userIds,
    this.avatarFileId,
    this.needApprovalOnPostCreation,
  });

  final String displayName;
  final List<String>? categoryIds;
  String? description;
  bool? isPublic;
  Metadata? metadata;
  List<String>? userIds;
  String? avatarFileId;
  bool? needApprovalOnPostCreation;

  factory CreateCommunityRequest.fromJson(Map<String, dynamic> json) =>
      CreateCommunityRequest(
        displayName: json["displayName"],
        categoryIds: List<String>.from(
            json["categoryIds"].map((categoryId) => categoryId.toString())),
        description: json["description"],
        isPublic: json["isPublic"],
        userIds: List<String>.from(
            json["userIds"].map((userId) => userId.toString())),
        avatarFileId: json["avatarFileId"],
        metadata: Metadata.fromJson(json["metadata"]),
        needApprovalOnPostCreation: json["needApprovalOnPostCreation"],
      );

  Map<String, dynamic> toJson() => {
        "displayName": displayName,
        "categoryIds": categoryIds,
        "description": description,
        "isPublic": isPublic,
        "metadata": metadata == null ? null : metadata!.toJson(),
        "userIds": userIds,
        "avatarFileId": avatarFileId,
        "needApprovalOnPostCreation": needApprovalOnPostCreation,
      }..removeWhere((key, value) => value == null);
  @override
  String toString() {
    return createPostRequestToJson(this);
  }
}

class Metadata {
  Metadata({
    required this.anything,
  });

  final String anything;

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        anything: json["anything"],
      );

  Map<String, dynamic> toJson() => {
        "anything": anything,
      };
}
