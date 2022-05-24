import 'package:amity_sdk/src/core/enum/amity_permission_type.dart';
import 'package:amity_sdk/src/core/model/api_request/community_member_check_request.dart';
import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/domain/usecase/community/permission/community_member_permission_check_usecase.dart';

class AmityCommunityPermissionValidator {
  final AmityPermission _permission;
  final String _communityId;
  final String _userId;

  AmityCommunityPermissionValidator(
      this._permission, this._communityId, this._userId);

  Future<bool> check() {
    return serviceLocator<CommunityMemberPermissionCheckUsecase>().get(
        CommunityMemberPermissionCheckRequest(
            communityId: _communityId,
            userId: _userId,
            permission: _permission));
  }
}
