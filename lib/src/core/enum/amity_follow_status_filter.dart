// ignore_for_file: constant_identifier_names

import 'package:amity_sdk/src/core/enum/enum.dart';

enum AmityFollowStatusFilter { ALL, ACCEPTED, PENDING }

extension AmityFollowStatusFilterExtension on AmityFollowStatusFilter {
  String get value {
    return [
      'all',
      'accepted',
      'pending',
    ][index];
  }

  List<String> get statuses {
    return [
      [AmityFollowStatus.ACCEPTED.value, AmityFollowStatus.PENDING.value],
      [AmityFollowStatus.ACCEPTED.value],
      [AmityFollowStatus.PENDING.value]
    ][index];
  }
}
