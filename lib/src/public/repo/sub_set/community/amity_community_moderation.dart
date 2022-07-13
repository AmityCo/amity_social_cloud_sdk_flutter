import 'package:amity_sdk/src/core/model/api_request/update_community_members_request.dart';
import 'package:amity_sdk/src/core/model/api_request/update_community_role_request.dart';
import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/domain/usecase/community/member/community_member_add_role_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/community/member/community_member_ban_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/community/member/community_member_remove_role_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/community/member/community_member_unban_usecase.dart';

/// Amity Community Moderation
class AmityCommunityModeration {
  final String _communityId;

  /// Init Amity Community Moderation
  AmityCommunityModeration(this._communityId);

  /// Add Community Role to User
  Future addRole(String role, List<String> userIds) {
    final request = UpdateCommunityRoleRequest(
        communityId: _communityId, userIds: userIds, role: role);
    return serviceLocator<CommunityMemberAddRoleUsecase>().get(request);
  }

  /// Remove Community Role to User
  Future removeRole(String role, List<String> userIds) {
    final request = UpdateCommunityRoleRequest(
        communityId: _communityId, userIds: userIds, role: role);
    return serviceLocator<CommunityMemberRemoveRoleUsecase>().get(request);
  }

  /// Ban User from the Community
  Future banMember(List<String> userIds) {
    final request = UpdateCommunityMembersRequest(
        communityId: _communityId, userIds: userIds);
    return serviceLocator<CommunityMemberBanUsecase>().get(request);
  }

  /// UnBan User from the Community
  Future unbanMember(List<String> userIds) {
    final request = UpdateCommunityMembersRequest(
        communityId: _communityId, userIds: userIds);
    return serviceLocator<CommunityMemberUnbanUsecase>().get(request);
  }
}
