// ignore_for_file: constant_identifier_names

import 'package:amity_sdk/src/core/enum/enum.dart';

enum AmityUserSortOption {
  DISPLAY,
  FIRST_CREATED,
  LAST_CREATED,
}

extension AmityUserSortOptionExtension on AmityUserSortOption {
  String get value {
    return [
      'displayName',
      'firstCreated',
      'lastCreated',
    ][index];
  }

  String get sortingColumn {
    return [
      'user.displayName',
      'user.createdAt',
      'user.createdAt',
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
