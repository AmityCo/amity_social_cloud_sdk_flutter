enum AmityWatcherDataFormat{ flv , hls, rtmp}

extension AmityWatcherDataFormatExtension on AmityWatcherDataFormat {
  String get name {
    switch (this) {
      case AmityWatcherDataFormat.flv:
        return 'flv';
      case AmityWatcherDataFormat.hls:
        return 'hls';
      case AmityWatcherDataFormat.rtmp:
        return 'rtmp';
      default:
        return "";
    }
  }

  static AmityWatcherDataFormat enumOf(String value) {
    return AmityWatcherDataFormat.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AmityWatcherDataFormat.flv,
    );
  }
}