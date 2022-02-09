class CommentEntity {
  CommentEntity({
    required this.commentId,
    required this.userId,
    required this.parentId,
    required this.rootId,
    required this.referenceId,
    required this.referenceType,
    required this.dataType,
    // required this.data,
    // required this.metadata,
    required this.childrenNumber,
    required this.flagCount,
    // required this.hashFlag,
    // required this.reactions,
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

  final String commentId;
  final String userId;
  final String parentId;
  final String rootId;
  final String referenceId;
  final String referenceType;
  final String dataType;
  // final DataClass data;
  // final DataClass metadata;
  final int childrenNumber;
  final int flagCount;
  // final HashFlag hashFlag;
  // final Reactions reactions;
  final int reactionsCount;
  final List<String> myReactions;
  final bool isDeleted;
  final DateTime editedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> children;
  final int segmentNumber;
  final String required;

  factory CommentEntity.fromJson(Map<String, dynamic> json) => CommentEntity(
        commentId: json["commentId"],
        userId: json["userId"],
        parentId: json["parentId"],
        rootId: json["rootId"],
        referenceId: json["referenceId"],
        referenceType: json["referenceType"],
        dataType: json["dataType"],
        // data: DataClass.fromJson(json["data"]),
        // metadata: DataClass.fromJson(json["metadata"]),
        childrenNumber: json["childrenNumber"],
        flagCount: json["flagCount"],
        // hashFlag: HashFlag.fromJson(json["hashFlag"]),
        // reactions: Reactions.fromJson(json["reactions"]),
        reactionsCount: json["reactionsCount"],
        myReactions: List<String>.from(json["myReactions"].map((x) => x)),
        isDeleted: json["isDeleted"],
        editedAt: DateTime.parse(json["editedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        children: List<String>.from(json["children"].map((x) => x)),
        segmentNumber: json["segmentNumber"],
        required: json["required"],
      );

  Map<String, dynamic> toJson() => {
        "commentId": commentId,
        "userId": userId,
        "parentId": parentId,
        "rootId": rootId,
        "referenceId": referenceId,
        "referenceType": referenceType,
        "dataType": dataType,
        // "data": data.toJson(),
        // "metadata": metadata.toJson(),
        "childrenNumber": childrenNumber,
        "flagCount": flagCount,
        // "hashFlag": hashFlag.toJson(),
        // "reactions": reactions.toJson(),
        "reactionsCount": reactionsCount,
        "myReactions": List<dynamic>.from(myReactions.map((x) => x)),
        "isDeleted": isDeleted,
        "editedAt": editedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "children": List<dynamic>.from(children.map((x) => x)),
        "segmentNumber": segmentNumber,
        "required": required,
      };
}
