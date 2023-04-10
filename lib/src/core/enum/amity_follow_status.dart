// ignore_for_file: constant_identifier_names

enum AmityFollowStatus { PENDING, ACCEPTED, NONE, BLOCKED }

extension AmityFollowStatusExtension on AmityFollowStatus {
  String get value {
    return [
      'pending',
      'accepted',
      'none',
      'blocked',
    ][index];
  }

  static AmityFollowStatus enumOf(String value) {
    return AmityFollowStatus.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AmityFollowStatus.NONE,
    );
  }
}
