import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/public/public.dart';

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
