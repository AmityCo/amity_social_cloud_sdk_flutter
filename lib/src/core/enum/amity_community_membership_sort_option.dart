// ignore_for_file: constant_identifier_names

import 'package:amity_sdk/src/core/core.dart';

/// [AmityCommunityMembershipSortOption]
enum AmityCommunityMembershipSortOption { FIRST_CREATED, LAST_CREATED }

/// [AmityCommunityMembershipSortOptionExtension]
extension AmityCommunityMembershipSortOptionExtension
    on AmityCommunityMembershipSortOption {
  String get apiKey {
    return [
      'firstCreated',
      'lastCreated',
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
