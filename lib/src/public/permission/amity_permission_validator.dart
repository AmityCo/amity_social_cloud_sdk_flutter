import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/public/permission/amity_channel_permission_validator.dart';
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

  /// Check permission with Channel
  AmityChannelPermissionValidator atChannel(String channelId) {
    return AmityChannelPermissionValidator(
        _permission, channelId, AmityCoreClient.getUserId());
  }

  /// Check Global permission
  AmityGlobalPermissionValidator atGlobal() {
    return AmityGlobalPermissionValidator(
        _permission, AmityCoreClient.getUserId());
  }
}
