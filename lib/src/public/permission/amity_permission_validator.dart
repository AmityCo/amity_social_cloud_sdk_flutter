import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/public/permission/amity_community_permission_validator.dart';
import 'package:amity_sdk/src/public/permission/amity_global_permission_validator.dart';

class AmityPermissionValidator {
  final AmityPermission _permission;

  AmityPermissionValidator(this._permission);

  AmityCommunityPermissionValidator atCommunity(String communityId) {
    return AmityCommunityPermissionValidator(
        _permission, communityId, AmityCoreClient.getUserId());
  }

  AmityGlobalPermissionValidator atGlobaal() {
    return AmityGlobalPermissionValidator(
        _permission, AmityCoreClient.getUserId());
  }
}
