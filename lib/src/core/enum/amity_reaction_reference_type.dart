// ignore_for_file: constant_identifier_names

enum AmityReactionReferenceType { POST, COMMENT, MESSAGE , STORY }

extension AmityReactionReferenceTypeExtension on AmityReactionReferenceType {
  String get value {
    return AmityReactionReferenceType.values[index].name.toLowerCase();
  }

  //TODO - this method need to acceesable with AmityDataType
  static AmityReactionReferenceType enumOf(String value) {
    return AmityReactionReferenceType.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AmityReactionReferenceType.POST,
    );
  }
}
