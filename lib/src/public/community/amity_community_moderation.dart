import 'package:amity_sdk/src/core/model/api_request/update_community_role_request.dart';
import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/domain/usecase/community/member/community_member_add_role_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/community/member/community_member_remove_role_usecase.dart';

class AmityCommunityModeration {
  final String _communityId;
  AmityCommunityModeration(this._communityId);

  Future addRole(String role, List<String> userIds) {
    final request = UpdateCommunityRoleRequest(
        communityId: _communityId, userIds: userIds, role: role);
    return serviceLocator<CommunityMemberAddRoleUsecase>().get(request);
  }

  Future removeRole(String role, List<String> userIds) {
    final request = UpdateCommunityRoleRequest(
        communityId: _communityId, userIds: userIds, role: role);
    return serviceLocator<CommunityMemberRemoveRoleUsecase>().get(request);
  }
}
