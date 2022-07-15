// ignore_for_file: constant_identifier_names

/// Amity Poll Status  Enum
enum AmityPollStatus {
  /// If poll is Open
  OPEN,

  /// If poll is already closed
  CLOSED,

  /// Unknow Type
  UNKNOWN,
}

/// Amity Poll Status Enum Extension
extension AmityPollStatusExtension on AmityPollStatus {
  /// Get the string value of Enum
  String get value {
    return AmityPollStatus.values[index].name.toLowerCase();
  }

  /// Get the Enum value from the String
  static AmityPollStatus enumOf(String value) {
    return AmityPollStatus.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AmityPollStatus.UNKNOWN,
    );
  }
}
