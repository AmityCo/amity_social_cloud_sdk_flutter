import 'package:amity_sdk/src/data/response/core_response/post_data_response.dart';

class PostResponse {
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
    // required this.metadata,
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
  });
  final String id;
  final String? path;
  final String postId;
  String? parentPostId;
  final String postedUserId;
  String? sharedUserId;
  final int sharedCount;
  final String targetId;
  final String targetType;
  final String dataType;
  final PostDataResponse data;
  // final DataClass metadata;
  final int flagCount;
  final HashFlag? hashFlag;
  final DateTime? editedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Map<String, int>? reactions;
  final int reactionsCount;
  final List<String> myReactions;
  final int commentsCount;
  final List<String> comments;
  final List<String> children;
  final bool isDeleted;
  final bool hasFlaggedComment;
  final bool hasFlaggedChildren;
  final String? feedId;
  final String? require;

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
        editedAt:
            json["editedAt"] == null ? null : DateTime.parse(json["editedAt"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        reactions: Map.from(json["reactions"]),
        reactionsCount: json["reactionsCount"],
        myReactions: List<String>.from(json["myReactions"].map((x) => x)),
        commentsCount: json["commentsCount"],
        comments: List<String>.from(json["comments"].map((x) => x)),
        children: List<String>.from(json["children"].map((x) => x)),
        isDeleted: json["isDeleted"],
        hasFlaggedComment: json["hasFlaggedComment"],
        hasFlaggedChildren: json["hasFlaggedChildren"],
        feedId: json["feedId"],
        require: json["required"],
      );

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
        // "metadata": metadata.toJson(),
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
      };
}

class HashFlag {
  HashFlag({
    required this.bits,
    required this.hashes,
    required this.hash,
  });

  final int bits;
  final int hashes;
  final String hash;

  factory HashFlag.fromJson(Map<String, dynamic> json) => HashFlag(
        bits: json["bits"],
        hashes: json["hashes"],
        hash: json["hash"],
      );

  Map<String, dynamic> toJson() => {
        "bits": bits,
        "hashes": hashes,
        "hash": hash,
      };
}
