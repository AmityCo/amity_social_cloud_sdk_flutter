// ignore_for_file: constant_identifier_names

enum AmityFollowStatus {
  PENDING,
  ACCEPTED,
  NONE,
}

extension AmityFollowStatusExtension on AmityFollowStatus {
  String get value {
    return [
      'pending',
      'accepted',
      'none',
    ][index];
  }

  static AmityFollowStatus enumOf(String value) {
    return AmityFollowStatus.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AmityFollowStatus.NONE,
    );
  }
}
