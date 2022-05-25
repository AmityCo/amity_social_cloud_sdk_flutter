// ignore_for_file: constant_identifier_names

enum AmityMentionType { CHANNEL, USER }

extension AmityMentionTypeExtension on AmityMentionType {
  String get value {
    return AmityMentionType.values[index].name.toLowerCase();
  }

  //TODO - this method need to acceesable with AmityDataType
  static AmityMentionType enumOf(String value) {
    return AmityMentionType.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AmityMentionType.USER,
    );
  }
}
