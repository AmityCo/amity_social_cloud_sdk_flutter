import 'dart:convert';

import 'core_response/core_response.dart';

// final getPostByIdResponse = getPostByIdResponseFromJson(jsonString);

GetPostByIdResponse getPostByIdResponseFromJson(String str) =>
    GetPostByIdResponse.fromJson(json.decode(str));

String getPostByIdResponseToJson(GetPostByIdResponse data) =>
    json.encode(data.toJson());

class GetPostByIdResponse {
  GetPostByIdResponse({
    required this.status,
    required this.data,
  });

  final String status;
  final GetPostByIdResponseData data;

  factory GetPostByIdResponse.fromJson(Map<String, dynamic> json) =>
      GetPostByIdResponse(
        status: json["status"],
        data: GetPostByIdResponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class GetPostByIdResponseData {
  GetPostByIdResponseData({
    required this.posts,
    required this.postChildren,
    required this.comments,
    required this.users,
    // required this.files,
    // required this.communities,
    // required this.communityUsers,
    // required this.categories,
  });

  final List<PostResponse> posts;
  final List<PostResponse> postChildren;
  final List<CommentResponse> comments;
  final List<UserResponse> users;
  // final List<FileElement> files;
  // final List<Community> communities;
  // final List<CommunityUser> communityUsers;
  // final List<Category> categories;

  factory GetPostByIdResponseData.fromJson(Map<String, dynamic> json) =>
      GetPostByIdResponseData(
        posts: List<PostResponse>.from(
            json["posts"].map((x) => PostResponse.fromJson(x))),
        postChildren: List<PostResponse>.from(
            json["postChildren"].map((x) => PostResponse.fromJson(x))),
        comments: List<CommentResponse>.from(
            json["comments"].map((x) => CommentResponse.fromJson(x))),
        users: List<UserResponse>.from(
            json["users"].map((x) => UserResponse.fromJson(x))),
        // files: List<FileElement>.from(
        //     json["files"].map((x) => FileElement.fromJson(x))),
        // communities: List<Community>.from(
        //     json["communities"].map((x) => Community.fromJson(x))),
        // communityUsers: List<CommunityUser>.from(
        //     json["communityUsers"].map((x) => CommunityUser.fromJson(x))),
        // categories: List<Category>.from(
        //     json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
        "postChildren": List<dynamic>.from(postChildren.map((x) => x.toJson())),
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        // "files": List<dynamic>.from(files.map((x) => x.toJson())),
        // "communities": List<dynamic>.from(communities.map((x) => x.toJson())),
        // "communityUsers":
        //     List<dynamic>.from(communityUsers.map((x) => x.toJson())),
        // "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

// class Category {
//   Category({
//     required this.categoryId,
//     required this.name,
//     required this.metadata,
//     required this.avatarFileId,
//     required this.isDeleted,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   final String categoryId;
//   final String name;
//   final DataClass metadata;
//   final String avatarFileId;
//   final bool isDeleted;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//         categoryId: json["categoryId"],
//         name: json["name"],
//         metadata: DataClass.fromJson(json["metadata"]),
//         avatarFileId: json["avatarFileId"],
//         isDeleted: json["isDeleted"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "categoryId": categoryId,
//         "name": name,
//         "metadata": metadata.toJson(),
//         "avatarFileId": avatarFileId,
//         "isDeleted": isDeleted,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//       };
// }

// class DataClass {
//   DataClass();

//   factory DataClass.fromJson(Map<String, dynamic> json) => DataClass();

//   Map<String, dynamic> toJson() => {};
// }


// class HashFlag {
//   HashFlag({
//     required this.bits,
//     required this.hashes,
//     required this.hash,
//   });

//   final int bits;
//   final int hashes;
//   final List<int> hash;

//   factory HashFlag.fromJson(Map<String, dynamic> json) => HashFlag(
//         bits: json["bits"],
//         hashes: json["hashes"],
//         hash: List<int>.from(json["hash"].map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "bits": bits,
//         "hashes": hashes,
//         "hash": List<dynamic>.from(hash.map((x) => x)),
//       };
// }

// class Reactions {
//   Reactions({
//     required this.like,
//   });

//   final int like;

//   factory Reactions.fromJson(Map<String, dynamic> json) => Reactions(
//         like: json["like"],
//       );

//   Map<String, dynamic> toJson() => {
//         "like": like,
//       };
// }

// class Community {
//   Community({
//     required this.communityId,
//     required this.channelId,
//     required this.userId,
//     required this.displayName,
//     required this.avatarFileId,
//     required this.description,
//     required this.isOfficial,
//     required this.isPublic,
//     required this.onlyAdminCanPost,
//     required this.tags,
//     required this.metadata,
//     required this.postsCount,
//     required this.membersCount,
//     required this.isJoined,
//     required this.categoryIds,
//     required this.isDeleted,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.hasFlaggedComment,
//     required this.hasFlaggedPost,
//     required this.needApprovalOnPostCreation,
//   });

//   final String communityId;
//   final String channelId;
//   final String userId;
//   final String displayName;
//   final String avatarFileId;
//   final String description;
//   final bool isOfficial;
//   final bool isPublic;
//   final bool onlyAdminCanPost;
//   final List<String> tags;
//   final DataClass metadata;
//   final int postsCount;
//   final int membersCount;
//   final bool isJoined;
//   final List<String> categoryIds;
//   final bool isDeleted;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final bool hasFlaggedComment;
//   final bool hasFlaggedPost;
//   final bool needApprovalOnPostCreation;

//   factory Community.fromJson(Map<String, dynamic> json) => Community(
//         communityId: json["communityId"],
//         channelId: json["channelId"],
//         userId: json["userId"],
//         displayName: json["displayName"],
//         avatarFileId: json["avatarFileId"],
//         description: json["description"],
//         isOfficial: json["isOfficial"],
//         isPublic: json["isPublic"],
//         onlyAdminCanPost: json["onlyAdminCanPost"],
//         tags: List<String>.from(json["tags"].map((x) => x)),
//         metadata: DataClass.fromJson(json["metadata"]),
//         postsCount: json["postsCount"],
//         membersCount: json["membersCount"],
//         isJoined: json["isJoined"],
//         categoryIds: List<String>.from(json["categoryIds"].map((x) => x)),
//         isDeleted: json["isDeleted"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         hasFlaggedComment: json["hasFlaggedComment"],
//         hasFlaggedPost: json["hasFlaggedPost"],
//         needApprovalOnPostCreation: json["needApprovalOnPostCreation"],
//       );

//   Map<String, dynamic> toJson() => {
//         "communityId": communityId,
//         "channelId": channelId,
//         "userId": userId,
//         "displayName": displayName,
//         "avatarFileId": avatarFileId,
//         "description": description,
//         "isOfficial": isOfficial,
//         "isPublic": isPublic,
//         "onlyAdminCanPost": onlyAdminCanPost,
//         "tags": List<dynamic>.from(tags.map((x) => x)),
//         "metadata": metadata.toJson(),
//         "postsCount": postsCount,
//         "membersCount": membersCount,
//         "isJoined": isJoined,
//         "categoryIds": List<dynamic>.from(categoryIds.map((x) => x)),
//         "isDeleted": isDeleted,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "hasFlaggedComment": hasFlaggedComment,
//         "hasFlaggedPost": hasFlaggedPost,
//         "needApprovalOnPostCreation": needApprovalOnPostCreation,
//       };
// }

// class CommunityUser {
//   CommunityUser({
//     required this.userId,
//     required this.channelId,
//     required this.communityId,
//     required this.communityMembership,
//     required this.isBanned,
//     required this.lastActivity,
//     required this.roles,
//     required this.permissions,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   final String userId;
//   final String channelId;
//   final String communityId;
//   final String communityMembership;
//   final bool isBanned;
//   final DateTime lastActivity;
//   final List<String> roles;
//   final List<String> permissions;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   factory CommunityUser.fromJson(Map<String, dynamic> json) => CommunityUser(
//         userId: json["userId"],
//         channelId: json["channelId"],
//         communityId: json["communityId"],
//         communityMembership: json["communityMembership"],
//         isBanned: json["isBanned"],
//         lastActivity: DateTime.parse(json["lastActivity"]),
//         roles: List<String>.from(json["roles"].map((x) => x)),
//         permissions: List<String>.from(json["permissions"].map((x) => x)),
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "userId": userId,
//         "channelId": channelId,
//         "communityId": communityId,
//         "communityMembership": communityMembership,
//         "isBanned": isBanned,
//         "lastActivity": lastActivity.toIso8601String(),
//         "roles": List<dynamic>.from(roles.map((x) => x)),
//         "permissions": List<dynamic>.from(permissions.map((x) => x)),
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//       };
// }

// class FileElement {
//   FileElement({
//     required this.fileId,
//     required this.fileUrl,
//     required this.type,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.attributes,
//   });

//   final String fileId;
//   final String fileUrl;
//   final String type;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final Attributes attributes;

//   factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
//         fileId: json["fileId"],
//         fileUrl: json["fileUrl"],
//         type: json["type"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         attributes: Attributes.fromJson(json["attributes"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "fileId": fileId,
//         "fileUrl": fileUrl,
//         "type": type,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "attributes": attributes.toJson(),
//       };
// }

// class Attributes {
//   Attributes({
//     required this.name,
//     required this.extension,
//     required this.size,
//     required this.mimeType,
//     required this.metadata,
//   });

//   final String name;
//   final String extension;
//   final String size;
//   final String mimeType;
//   final AttributesMetadata metadata;

//   factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
//         name: json["name"],
//         extension: json["extension"],
//         size: json["size"],
//         mimeType: json["mimeType"],
//         metadata: AttributesMetadata.fromJson(json["metadata"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "extension": extension,
//         "size": size,
//         "mimeType": mimeType,
//         "metadata": metadata.toJson(),
//       };
// }

// class AttributesMetadata {
//   AttributesMetadata({
//     required this.exif,
//     required this.gps,
//     required this.height,
//     required this.width,
//     required this.isFull,
//   });

//   final DataClass exif;
//   final DataClass gps;
//   final int height;
//   final int width;
//   final bool isFull;

//   factory AttributesMetadata.fromJson(Map<String, dynamic> json) =>
//       AttributesMetadata(
//         exif: DataClass.fromJson(json["exif"]),
//         gps: DataClass.fromJson(json["gps"]),
//         height: json["height"],
//         width: json["width"],
//         isFull: json["isFull"],
//       );

//   Map<String, dynamic> toJson() => {
//         "exif": exif.toJson(),
//         "gps": gps.toJson(),
//         "height": height,
//         "width": width,
//         "isFull": isFull,
//       };
// }


// class PostChildData {
//   PostChildData({
//     required this.text,
//     required this.fileId,
//     required this.thumbnailFileId,
//     required this.videoFileId,
//     required this.streamId,
//   });

//   final String text;
//   final String fileId;
//   final String thumbnailFileId;
//   final VideoFileId videoFileId;
//   final String streamId;

//   factory PostChildData.fromJson(Map<String, dynamic> json) => PostChildData(
//         text: json["text"],
//         fileId: json["fileId"],
//         thumbnailFileId: json["thumbnailFileId"],
//         videoFileId: VideoFileId.fromJson(json["videoFileId"]),
//         streamId: json["streamId"],
//       );

//   Map<String, dynamic> toJson() => {
//         "text": text,
//         "fileId": fileId,
//         "thumbnailFileId": thumbnailFileId,
//         "videoFileId": videoFileId.toJson(),
//         "streamId": streamId,
//       };
// }

// class VideoFileId {
//   VideoFileId({
//     required this.original,
//     required this.low,
//     required this.medium,
//     required this.high,
//   });

//   final String original;
//   final String low;
//   final String medium;
//   final String high;

//   factory VideoFileId.fromJson(Map<String, dynamic> json) => VideoFileId(
//         original: json["original"],
//         low: json["low"],
//         medium: json["medium"],
//         high: json["high"],
//       );

//   Map<String, dynamic> toJson() => {
//         "original": original,
//         "low": low,
//         "medium": medium,
//         "high": high,
//       };
// }

