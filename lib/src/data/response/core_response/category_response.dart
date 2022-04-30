class CategoryResponse {
  CategoryResponse({
    required this.categoryId,
    required this.name,
    // required this.metadata,
    required this.avatarFileId,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? categoryId;
  final String? name;
  // final DataClass metadata;
  final String? avatarFileId;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      CategoryResponse(
        categoryId: json["categoryId"],
        name: json["name"],
        // metadata: DataClass.fromJson(json["metadata"]),
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
        // "metadata": metadata.toJson(),
        "avatarFileId": avatarFileId,
        "isDeleted": isDeleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
