import 'package:amity_sdk/amity_sdk.dart';

class CommunityMemberPermissionCheckRequest {
  final String communityId;
  final String userId;
  final AmityPermission permission;

  CommunityMemberPermissionCheckRequest(
      {required this.communityId,
      required this.userId,
      required this.permission});
}
