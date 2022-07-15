// ignore_for_file: constant_identifier_names

/// Amity Poll Answer Data Type Enum
enum AmityPollAnswerDataType {
  /// If Answer data type is text
  TEXT,

  /// Unknow Type
  UNKNOWN,
}

/// Amity Poll Answer Data Type Enum Extension
extension AmityPollAnswerDataTypeExtension on AmityPollAnswerDataType {
  /// Get the string value of Enum
  String get value {
    return AmityPollAnswerDataType.values[index].name.toLowerCase();
  }

  /// Get the Enum value from the String
  static AmityPollAnswerDataType enumOf(String value) {
    return AmityPollAnswerDataType.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AmityPollAnswerDataType.UNKNOWN,
    );
  }
}
