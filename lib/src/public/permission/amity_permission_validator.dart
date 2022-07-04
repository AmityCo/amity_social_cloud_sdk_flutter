import 'package:amity_sdk/amity_sdk.dart';

class AmityPermissionValidator {
  final AmityPermission _permission;

  AmityPermissionValidator(this._permission);

  AmityCommunityPermissionValidator atCommunity(String communityId) {
    return AmityCommunityPermissionValidator(
        _permission, communityId, AmityCoreClient.getUserId());
  }

  AmityGlobalPermissionValidator atGlobal() {
    return AmityGlobalPermissionValidator(
        _permission, AmityCoreClient.getUserId());
  }
}
