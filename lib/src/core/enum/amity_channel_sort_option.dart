import 'package:amity_sdk/src/core/core.dart';

/// Amity Channel Type
// ignore_for_file: constant_identifier_names, public_member_api_docs

/// [AmityChannelSortOption]
enum AmityChannelSortOption {
  LAST_ACTIVITY,
}

/// [AmityChannelTypeExtension]
extension AmityChannelSortOptionExtension on AmityChannelSortOption {
  String get value {
    switch (index) {
      case 0:
        return 'lastActivity';
      default:
        return 'lastActivity';
    }
  }

  //TODO - this method need to acceesable with AmityChannelType
  static AmityChannelSortOption enumOf(String value) {
    return AmityChannelSortOption.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AmityChannelSortOption.LAST_ACTIVITY,
    );
  }
}
