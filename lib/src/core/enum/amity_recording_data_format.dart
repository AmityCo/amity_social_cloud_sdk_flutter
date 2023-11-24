enum AmityRecordingDataFormat{ flv , mp4, m3u8}

extension AmityRecordingDataFormatExtension on AmityRecordingDataFormat {
  String get name {
    switch (this) {
      case AmityRecordingDataFormat.flv:
        return 'flv';
      case AmityRecordingDataFormat.mp4:
        return 'mp4';
      case AmityRecordingDataFormat.m3u8:
        return 'm3u8';
      default:
        return "";
    }
  }

  static AmityRecordingDataFormat enumOf(String value) {
    return AmityRecordingDataFormat.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AmityRecordingDataFormat.flv,
    );
  }
}