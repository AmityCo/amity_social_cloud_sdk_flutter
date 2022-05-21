// ignore_for_file: constant_identifier_names

import 'package:amity_sdk/src/core/enum/enum.dart';

enum AmityCommunitySortOption { DISPLAY_NAME, FIRST_CREATED, LAST_CREATED }

extension AmityCommunitySortOptionExtension on AmityCommunitySortOption {
  String get apiKey {
    return [
      'displayName',
      'firstCreated',
      'lastCreated',
    ][index];
  }

  String get sortingColumn {
    return [
      'community.displayName',
      'comment.createdAt',
      'comment.createdAt',
    ][index];
  }

  String get sortingOrder {
    return [
      AmityQuerySortingOrder.ASC.sqlOrder,
      AmityQuerySortingOrder.ASC.sqlOrder,
      AmityQuerySortingOrder.DESC.sqlOrder,
    ][index];
  }
}
