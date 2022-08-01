// ignore_for_file: constant_identifier_names

/// Amity Poll Answer Type Enum
enum AmityPollAnswerType {
  /// If user can select single answer only
  SINGLE,

  /// If user can select Multiple answer
  MULTIPLE,

  /// Unknow Type
  UNKNOWN,
}

/// Amity Poll Answer Type Enum Extension
extension AmityPollAnswerTypeExtension on AmityPollAnswerType {
  /// Get the string value of Enum
  String get value {
    return AmityPollAnswerType.values[index].name.toLowerCase();
  }

  /// Get the Enum value from the String
  static AmityPollAnswerType enumOf(String value) {
    return AmityPollAnswerType.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AmityPollAnswerType.UNKNOWN,
    );
  }
}
