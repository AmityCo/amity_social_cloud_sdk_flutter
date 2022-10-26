import 'package:amity_sdk/src/core/core.dart';

/// [CommunityMemberPermissionCheckRequest]
class CommunityMemberPermissionCheckRequest {
  /// Community Id
  final String communityId;

  /// User Id
  final String userId;

  /// Permission to Check
  final AmityPermission? permission;

  /// Init [CommunityMemberPermissionCheckRequest]
  CommunityMemberPermissionCheckRequest(
      {required this.communityId, required this.userId, this.permission});
}
