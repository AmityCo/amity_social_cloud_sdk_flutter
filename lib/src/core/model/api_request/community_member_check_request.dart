import 'package:amity_sdk/src/core/core.dart';

class CommunityMemberPermissionCheckRequest {
  final String communityId;
  final String userId;
  final AmityPermission permission;

  CommunityMemberPermissionCheckRequest(
      {required this.communityId,
      required this.userId,
      required this.permission});
}
