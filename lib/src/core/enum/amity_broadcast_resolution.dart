enum AmityBroadcastResolution{ SD_480P , HD_720P, FD_1080P}

extension AmityBroadcastResolutionExtension on AmityBroadcastResolution {
  String get name {
    switch (this) {
      case AmityBroadcastResolution.SD_480P:
        return 'idle';
      case AmityBroadcastResolution.HD_720P:
        return 'live';
      case AmityBroadcastResolution.FD_1080P:
        return 'ended';
      default:
        return "";
    }
  }

  static AmityBroadcastResolution enumOf(String value) {
    return AmityBroadcastResolution.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AmityBroadcastResolution.SD_480P,
    );
  }
}