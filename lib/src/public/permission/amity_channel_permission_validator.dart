import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/usecase/channel/permission/channel_member_permission_check_usecase.dart';

/// [AmityChannelPermissionValidator]
class AmityChannelPermissionValidator {
  final AmityPermission _permission;
  final String _channelId;
  final String _userId;

  /// Init [AmityChannelPermissionValidator]
  AmityChannelPermissionValidator(
      this._permission, this._channelId, this._userId);

  /// Check permission action
  bool check() {
    return serviceLocator<ChannelMemberPermissionCheckUsecase>().get(
        ChannelMemberPermissionCheckRequest(
            channelId: _channelId, userId: _userId, permission: _permission));
  }
}
