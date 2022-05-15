import 'dart:convert';

CreateCommunityRequest createPostRequestFromJson(String str) =>
    CreateCommunityRequest.fromJson(json.decode(str));

String createPostRequestToJson(CreateCommunityRequest data) =>
    json.encode(data.toJson());

class CreateCommunityRequest {
  CreateCommunityRequest({
    this.communityId,
    this.displayName,
    this.categoryIds,
    this.description,
    this.isPublic,
    this.metadata,
    this.userIds,
    this.avatarFileId,
    this.needApprovalOnPostCreation,
  });
  String? communityId;
  String? displayName;
  List<String>? categoryIds;
  String? description;
  bool? isPublic;
  Map<String, String>? metadata;
  List<String>? userIds;
  String? avatarFileId;
  bool? needApprovalOnPostCreation;

  factory CreateCommunityRequest.fromJson(Map<String, dynamic> json) =>
      CreateCommunityRequest(
        communityId: json["communityId"],
        displayName: json["displayName"],
        categoryIds: List<String>.from(
            json["categoryIds"].map((categoryId) => categoryId.toString())),
        description: json["description"],
        isPublic: json["isPublic"],
        userIds: List<String>.from(
            json["userIds"].map((userId) => userId.toString())),
        avatarFileId: json["avatarFileId"],
        metadata: json["metadata"],
        needApprovalOnPostCreation: json["needApprovalOnPostCreation"],
      );

  Map<String, dynamic> toJson() => {
        "communityId": communityId,
        "displayName": displayName,
        "categoryIds": categoryIds,
        "description": description,
        "isPublic": isPublic,
        "metadata": metadata,
        "userIds": userIds,
        "avatarFileId": avatarFileId,
        "needApprovalOnPostCreation": needApprovalOnPostCreation,
      }..removeWhere((key, value) => value == null);
  @override
  String toString() {
    return createPostRequestToJson(this);
  }
}
