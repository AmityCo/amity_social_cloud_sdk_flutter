// ignore_for_file: constant_identifier_names

enum AmityCommentTargetType { COMMUNITY, USER, CONTENT, UNKNOWN  }

extension AmityCommentTargetTypeExtension on AmityCommentTargetType {
  // String get value {
  //   return [
  //     'user',
  //     'community',
  //   ][index];
  // }

  String get value {
    return AmityCommentTargetType.values[index].name.toLowerCase();
  }

  //TODO - this method need to acceesable with AmityDataType
  static AmityCommentTargetType enumOf(String value) {
    return AmityCommentTargetType.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AmityCommentTargetType.UNKNOWN,
    );
  }
}

