class CommunityCategoryResponse {
  CommunityCategoryResponse({
    required this.categoryId,
    required this.name,
    required this.metadata,
    required this.avatarFileId,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? categoryId;
  final String? name;
  final Map<String, dynamic>? metadata;
  final String? avatarFileId;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory CommunityCategoryResponse.fromJson(Map<String, dynamic> json) =>
      CommunityCategoryResponse(
        categoryId: json["categoryId"],
        name: json["name"],
        metadata: json["metadata"],
        avatarFileId: json["avatarFileId"],
        isDeleted: json["isDeleted"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "name": name,
        "metadata": metadata,
        "avatarFileId": avatarFileId,
        "isDeleted": isDeleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
