import 'package:amity_sdk/src/src.dart';

enum TombstoneModelType {
  USER,
  MESSAGE,
  POST,
  CHANNEL,
  COMMUNITY,
  CATEGORY,
  FOLLOW_COUNT,
  SUB_CHANNEL,
  UNKNOWN
}

extension TombStoneTypeExtension on TombstoneModelType {
  String get value {
    return TombstoneModelType.values[index].name.toLowerCase();
  }

  static TombstoneModelType enumOf(String value) {

    return TombstoneModelType.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => TombstoneModelType.UNKNOWN,
    );
  }
}
