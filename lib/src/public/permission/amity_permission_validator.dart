import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/public/public.dart';

/// [AmityPermissionValidator]
class AmityPermissionValidator {
  final AmityPermission _permission;

  /// Init [AmityPermissionValidator]
  AmityPermissionValidator(this._permission);

  /// Check permission with Community
  AmityCommunityPermissionValidator atCommunity(String communityId) {
    return AmityCommunityPermissionValidator(
        _permission, communityId, AmityCoreClient.getUserId());
  }

  /// Check Global permission
  AmityGlobalPermissionValidator atGlobal() {
    return AmityGlobalPermissionValidator(
        _permission, AmityCoreClient.getUserId());
  }
}
