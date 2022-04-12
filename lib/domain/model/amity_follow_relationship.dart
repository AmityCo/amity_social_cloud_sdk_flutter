import 'dart:convert';

import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/model/amity_user.dart';

class AmityFollowRelationship {
  String? sourceUserId;
  String? targetUserId;
  AmityUser? sourceUser;
  AmityUser? targetUser;
  AmityFollowStatus? status = AmityFollowStatus.NONE;

  @override
  String toString() {
    return 'AmityFollowRelationship(sourceUserId: $sourceUserId, targetUserId: $targetUserId, sourceUser: $sourceUser, targetUser: $targetUser, status: $status)';
  }

  Map<String, dynamic> toMap() {
    return {
      'sourceUserId': sourceUserId,
      'targetUserId': targetUserId,
      'sourceUser': sourceUser?.toMap(),
      'targetUser': targetUser?.toMap(),
      'status': status?.value,
    };
  }

  String toJson() => json.encode(toMap());
}
