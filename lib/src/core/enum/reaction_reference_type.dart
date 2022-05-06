// ignore_for_file: constant_identifier_names

enum ReactionReferenceType {
  POST,
  MESSAGE,
  COMMENT,
}

extension ReactionReferenceTypeExtension on ReactionReferenceType {
  String get value {
    return ReactionReferenceType.values[index].name.toLowerCase();
  }

  //TODO: - this method need to acceesable with ReactionReferenceType
  static ReactionReferenceType enumOf(String value) {
    return ReactionReferenceType.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => ReactionReferenceType.POST,
    );
  }
}
