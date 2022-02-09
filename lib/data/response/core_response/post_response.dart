class PostResponse {
  PostResponse({
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
    // required this.hashFlag,
    required this.editedAt,
    required this.createdAt,
    required this.updatedAt,
    // required this.reactions,
    required this.reactionsCount,
    required this.myReactions,
    required this.commentsCount,
    required this.comments,
    required this.children,
    required this.isDeleted,
    required this.hasFlaggedComment,
    required this.hasFlaggedChildren,
    required this.feedId,
    required this.required,
  });

  final String postId;
  final String parentPostId;
  final String postedUserId;
  final String sharedUserId;
  final int sharedCount;
  final String targetId;
  final String targetType;
  final String dataType;
  final PostChildData data;
  // final DataClass metadata;
  final int flagCount;
  // final HashFlag hashFlag;
  final DateTime editedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  // final Reactions reactions;
  final int reactionsCount;
  final List<String> myReactions;
  final int commentsCount;
  final List<String> comments;
  final List<String> children;
  final bool isDeleted;
  final bool hasFlaggedComment;
  final bool hasFlaggedChildren;
  final String feedId;
  final String required;

  factory PostResponse.fromJson(Map<String, dynamic> json) => PostResponse(
        postId: json["postId"],
        parentPostId: json["parentPostId"],
        postedUserId: json["postedUserId"],
        sharedUserId: json["sharedUserId"],
        sharedCount: json["sharedCount"],
        targetId: json["targetId"],
        targetType: json["targetType"],
        dataType: json["dataType"],
        data: PostChildData.fromJson(json["data"]),
        // metadata: DataClass.fromJson(json["metadata"]),
        flagCount: json["flagCount"],
        // hashFlag: HashFlag.fromJson(json["hashFlag"]),
        editedAt: DateTime.parse(json["editedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        // reactions: Reactions.fromJson(json["reactions"]),
        reactionsCount: json["reactionsCount"],
        myReactions: List<String>.from(json["myReactions"].map((x) => x)),
        commentsCount: json["commentsCount"],
        comments: List<String>.from(json["comments"].map((x) => x)),
        children: List<String>.from(json["children"].map((x) => x)),
        isDeleted: json["isDeleted"],
        hasFlaggedComment: json["hasFlaggedComment"],
        hasFlaggedChildren: json["hasFlaggedChildren"],
        feedId: json["feedId"],
        required: json["required"],
      );

  Map<String, dynamic> toJson() => {
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
        // "hashFlag": hashFlag.toJson(),
        "editedAt": editedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        // "reactions": reactions.toJson(),
        "reactionsCount": reactionsCount,
        "myReactions": List<dynamic>.from(myReactions.map((x) => x)),
        "commentsCount": commentsCount,
        "comments": List<dynamic>.from(comments.map((x) => x)),
        "children": List<dynamic>.from(children.map((x) => x)),
        "isDeleted": isDeleted,
        "hasFlaggedComment": hasFlaggedComment,
        "hasFlaggedChildren": hasFlaggedChildren,
        "feedId": feedId,
        "required": required,
      };
}

class PostChildData {
  PostChildData({
    required this.text,
    required this.fileId,
    required this.thumbnailFileId,
    required this.videoFileId,
    required this.streamId,
  });

  final String text;
  final String fileId;
  final String thumbnailFileId;
  final VideoFileId videoFileId;
  final String streamId;

  factory PostChildData.fromJson(Map<String, dynamic> json) => PostChildData(
        text: json["text"],
        fileId: json["fileId"],
        thumbnailFileId: json["thumbnailFileId"],
        videoFileId: VideoFileId.fromJson(json["videoFileId"]),
        streamId: json["streamId"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "fileId": fileId,
        "thumbnailFileId": thumbnailFileId,
        "videoFileId": videoFileId.toJson(),
        "streamId": streamId,
      };
}

class VideoFileId {
  VideoFileId({
    required this.original,
    required this.low,
    required this.medium,
    required this.high,
  });

  final String original;
  final String low;
  final String medium;
  final String high;

  factory VideoFileId.fromJson(Map<String, dynamic> json) => VideoFileId(
        original: json["original"],
        low: json["low"],
        medium: json["medium"],
        high: json["high"],
      );

  Map<String, dynamic> toJson() => {
        "original": original,
        "low": low,
        "medium": medium,
        "high": high,
      };
}
