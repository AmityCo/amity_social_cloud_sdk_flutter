// ignore_for_file: constant_identifier_names

import 'package:amity_sdk/src/core/enum/enum.dart';

enum AmityCommentSortOption { FIRST_CREATED, LAST_CREATED, FIRST_UPDATED, LAST_UPDATED }

extension AmityCommentSortOptionExtension on AmityCommentSortOption {
  String get apiKey {
    return [
      'firstCreated',
      'lastCreated',
      'firstUpdated',
      'lastUpdated',
    ][index];
  }

  String get sortingColumn {
    return [
      'comment.createdAt',
      'comment.createdAt',
    ][index];
  }

  String get sortingOrder {
    return [
      AmityQuerySortingOrder.ASC.sqlOrder,
      AmityQuerySortingOrder.DESC.sqlOrder,
    ][index];
  }
}
