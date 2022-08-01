import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/model/amity_user.dart';

class AmityFollowRelationship {
  String? sourceUserId;
  String? targetUserId;
  AmityUser? sourceUser;
  AmityUser? targetUser;
  AmityFollowStatus? status = AmityFollowStatus.NONE;
}
