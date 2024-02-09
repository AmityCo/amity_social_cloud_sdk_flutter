import 'dart:convert';

import 'package:amity_sdk/src/data/data.dart';

/// Post Response from BR
class PostResponse {
  /// init [PostResponse]
  PostResponse({
    required this.id,
    required this.path,
    required this.postId,
    required this.parentPostId,
    required this.postedUserId,
    required this.sharedUserId,
    required this.sharedCount,
    required this.targetId,
    required this.targetType,
    required this.dataType,
    required this.data,
    required this.metadata,
    required this.flagCount,
    required this.hashFlag,
    required this.editedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.reactions,
    required this.reactionsCount,
    required this.myReactions,
    required this.commentsCount,
    required this.comments,
    required this.children,
    required this.isDeleted,
    required this.hasFlaggedComment,
    required this.hasFlaggedChildren,
    required this.feedId,
    required this.require,
    required this.mentionees,
    required this.impression,
    required this.reach,
  });

  /// Doc id
  final String id;

  /// Doc path
  final String? path;

  /// post Id
  final String postId;

  /// if post is child post, parent post Id
  String? parentPostId;

  /// user id for the post owner
  final String postedUserId;

  /// user id for the shared with user
  String? sharedUserId;

  /// share count
  final int sharedCount;

  /// target user/community id
  final String targetId;

  /// post target type user/community
  final String targetType;

  /// data type  - text/imgae/video/file
  final String dataType;

  /// post data
  final PostDataResponse data;

  /// metadata
  final Map<String, dynamic>? metadata;

  ///flag count
  final int flagCount;

  /// hash flag bloom filter data
  final HashFlag? hashFlag;

  /// edit data
  final DateTime? editedAt;

  /// create data
  final DateTime? createdAt;

  /// update data
  final DateTime? updatedAt;

  /// reaction map
  final Map<String, int>? reactions;

  /// reaction count
  final int reactionsCount;

  /// my reaction on the post
  final List<String> myReactions;

  /// comment count
  final int commentsCount;

  /// intial comment
  final List<String> comments;

  /// child post id
  final List<String> children;

  /// deleted flag
  final bool isDeleted;

  /// if post has flagged comment
  final bool hasFlaggedComment;

  /// if post have flagged child psot
  final bool hasFlaggedChildren;

  /// feed if
  final String? feedId;

  /// require
  final String? require;

  /// Mentions
  final List<Mentionee> mentionees;

  /// impression count
  final int impression;

  /// reach count
  final int reach;

  /// factory method to init [PostResponse] from map
  factory PostResponse.fromJson(Map<String, dynamic> json) => PostResponse(
        id: json["_id"],
        path: json["path"],
        postId: json["postId"],
        parentPostId: json["parentPostId"],
        postedUserId: json["postedUserId"],
        sharedUserId: json["sharedUserId"],
        sharedCount: json["sharedCount"],
        targetId: json["targetId"],
        targetType: json["targetType"],
        dataType: json["dataType"],
        data: PostDataResponse.fromJson(json["data"]),
        // metadata: DataClass.fromJson(json["metadata"]),
        flagCount: json["flagCount"],
        hashFlag: json["hashFlag"] == null
            ? null
            : HashFlag.fromJson(json["hashFlag"]),
        editedAt: json["editedAt"] == null
            ? null
            : DateTime.tryParse(json["editedAt"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.tryParse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.tryParse(json["updatedAt"]),
        reactions: Map.from(json["reactions"]),
        reactionsCount: json["reactionsCount"],
        myReactions:
            List<String>.from(json["myReactions"]?.map((x) => x) ?? []),
        commentsCount: json["commentsCount"],
        comments: List<String>.from(json["comments"].map((x) => x)),
        children: List<String>.from(json["children"].map((x) => x)),
        isDeleted: json["isDeleted"],
        hasFlaggedComment: json["hasFlaggedComment"],
        hasFlaggedChildren: json["hasFlaggedChildren"],
        feedId: json["feedId"],
        require: json["required"],
        metadata: json["metadata"],
        impression: json["impression"],
        reach: json["reach"],
        mentionees: List<Mentionee>.from(
            json["mentionees"].map((x) => Mentionee.fromJson(x))),
      );

  /// Create map from [PostResponse]
  Map<String, dynamic> toJson() => {
        "_id": id,
        "path": path,
        "postId": postId,
        "parentPostId": parentPostId,
        "postedUserId": postedUserId,
        "sharedUserId": sharedUserId,
        "sharedCount": sharedCount,
        "targetId": targetId,
        "targetType": targetType,
        "dataType": dataType,
        "data": data.toJson(),
        "metadata": jsonEncode(metadata),
        "flagCount": flagCount,
        "hashFlag": hashFlag == null ? null : hashFlag!.toJson(),
        "editedAt": editedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "reactions": reactions,
        "reactionsCount": reactionsCount,
        "myReactions": List<dynamic>.from(myReactions.map((x) => x)),
        "commentsCount": commentsCount,
        "comments": List<dynamic>.from(comments.map((x) => x)),
        "children": List<dynamic>.from(children.map((x) => x)),
        "isDeleted": isDeleted,
        "hasFlaggedComment": hasFlaggedComment,
        "hasFlaggedChildren": hasFlaggedChildren,
        "feedId": feedId,
        "required": require,
        "impression": impression,
        "reach": reach,
        "mentionees": List<dynamic>.from(mentionees.map((x) => x.toJson())),
      };
}

/// Hash Flag
class HashFlag {
  /// init [HashFlag]
  HashFlag({
    required this.bits,
    required this.hashes,
    required this.hash,
  });

  /// bits
  final int bits;

  ///hashes
  final int hashes;

  ///hash
  final String hash;

  /// factory method to init [HashFlag]
  factory HashFlag.fromJson(Map<String, dynamic> json) => HashFlag(
        bits: json["bits"],
        hashes: json["hashes"],
        hash: json["hash"],
      );

  /// Convert [HashFlag] to map
  Map<String, dynamic> toJson() => {
        "bits": bits,
        "hashes": hashes,
        "hash": hash,
      };
}
