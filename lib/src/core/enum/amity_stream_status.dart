enum AmityStreamStatus{ idle , live, ended, recorded}

extension AmityStreamStatusExtension on AmityStreamStatus {
  String get name {
    switch (this) {
      case AmityStreamStatus.idle:
        return 'idle';
      case AmityStreamStatus.live:
        return 'live';
      case AmityStreamStatus.ended:
        return 'ended';
      case AmityStreamStatus.recorded:
        return 'recorded';
      default:
        return "";
    }
  }

  static AmityStreamStatus enumOf(String value) {
    return AmityStreamStatus.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AmityStreamStatus.idle,
    );
  }
}