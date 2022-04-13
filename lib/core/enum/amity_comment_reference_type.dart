// ignore_for_file: constant_identifier_names

enum AmityCommentReferenceType { POST }

extension AmityCommentReferenceTypeExtension on AmityCommentReferenceType {
  String get value {
    return AmityCommentReferenceType.values[index].name.toLowerCase();
  }

  //TODO: - this method need to acceesable with AmityCommentReferenceType
  static AmityCommentReferenceType enumOf(String value) {
    return AmityCommentReferenceType.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AmityCommentReferenceType.POST,
    );
  }
}
