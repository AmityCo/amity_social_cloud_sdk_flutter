import 'package:amity_sdk/src/data/data.dart';

class CommentResponse {
  CommentResponse({
    required this.id,
    required this.path,
    required this.commentId,
    required this.userId,
    required this.parentId,
    required this.rootId,
    required this.referenceId,
    required this.referenceType,
    required this.dataType,
    required this.data,
    required this.metadata,
    required this.childrenNumber,
    required this.flagCount,
    required this.hashFlag,
    required this.reactions,
    required this.reactionsCount,
    required this.myReactions,
    required this.isDeleted,
    required this.editedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.children,
    required this.segmentNumber,
    required this.required,
  });
  final String id;
  final String path;
  final String commentId;
  final String userId;
  final String? parentId;
  final String? rootId;
  final String referenceId;
  final String referenceType;
  final String dataType;
  final PostDataResponse data;
  final Map<String, dynamic>? metadata;
  final int childrenNumber;
  final int flagCount;
  final HashFlag? hashFlag;
  final Map<String, int>? reactions;
  final int reactionsCount;
  final List<String>? myReactions;
  final bool isDeleted;
  final DateTime? editedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<String> children;
  final int segmentNumber;
  final String? required;

  factory CommentResponse.fromJson(Map<String, dynamic> json) =>
      CommentResponse(
        id: json["_id"],
        path: json["path"],
        commentId: json["commentId"],
        userId: json["userId"],
        parentId: json["parentId"],
        rootId: json["rootId"],
        referenceId: json["referenceId"],
        referenceType: json["referenceType"],
        dataType: json["dataType"],
        data: PostDataResponse.fromJson(json["data"]),
        // metadata: DataClass.fromJson(json["metadata"]),
        childrenNumber: json["childrenNumber"],
        flagCount: json["flagCount"],
        hashFlag: json["hashFlag"] == null
            ? null
            : HashFlag.fromJson(json["hashFlag"]),
        reactions: Map.from(json["reactions"]),
        reactionsCount: json["reactionsCount"],
        myReactions: json["myReactions"] == null
            ? null
            : List<String>.from(json["myReactions"]!.map((x) => x)),
        isDeleted: json["isDeleted"],
        editedAt:
            json["editedAt"] == null ? null : DateTime.parse(json["editedAt"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        children: List<String>.from(json["children"].map((x) => x)),
        segmentNumber: json["segmentNumber"],
        metadata: json["metadata"],
        required: json["required"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "path": path,
        "commentId": commentId,
        "userId": userId,
        "parentId": parentId,
        "rootId": rootId,
        "referenceId": referenceId,
        "referenceType": referenceType,
        "dataType": dataType,
        "data": data.toJson(),
        // "metadata": metadata.toJson(),
        "childrenNumber": childrenNumber,
        "flagCount": flagCount,
        "hashFlag": hashFlag == null ? null : hashFlag!.toJson(),
        "reactions": reactions,
        "reactionsCount": reactionsCount,
        "myReactions": myReactions == null
            ? null
            : List<dynamic>.from(myReactions!.map((x) => x)),
        "isDeleted": isDeleted,
        "editedAt": editedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "children": List<dynamic>.from(children.map((x) => x)),
        "segmentNumber": segmentNumber,
        "metadata": metadata,
        "required": required,
      };
}
