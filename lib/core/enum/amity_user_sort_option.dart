// ignore_for_file: constant_identifier_names

import 'package:amity_sdk/core/enum/amity_query_sorting_order.dart';

enum AmityUserSortOption {
  DISPLAY,
  FIRST_CREATED,
  LAST_CREATED,
}

extension AmityUserSortOptionExtension on AmityUserSortOption {
  String get apiKey {
    return [
      'displayName',
      'user.displayName',
      'user.displayName',
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
