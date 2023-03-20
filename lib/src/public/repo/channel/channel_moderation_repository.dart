import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [ChannelModerationRepository]
class ChannelModerationRepository {
  /// Channel ID
  late String _channelId;

  /// Get member for the channel Id
  ChannelModerationRepository channelId(String id) {
    _channelId = id;
    return this;
  }

  /* begin_public_function 
  id: channel.moderation.add_roles
  */
  Future addRole(String role, List<String> userIds) {
    return serviceLocator<ChannelMemberAddRoleUsecase>()
        .get(UpdateChannelRoleRequest(channelId: _channelId, role: role, userIds: userIds));
  }
  /* end_public_function */

  /* begin_public_function 
  id: channel.moderation.remove_roles
  */
  Future removeRole(String role, List<String> userIds) {
    return serviceLocator<ChannelMemberRemoveRoleUsecase>()
        .get(UpdateChannelRoleRequest(channelId: _channelId, role: role, userIds: userIds));
  }
  /* end_public_function */

  /* begin_public_function 
  id: channel.moderation.mute_members
  */
  Future muteMembers(List<String> userIds, {int millis = 600000}) {
    return serviceLocator<ChannelMemberMuteUsecase>()
        .get(UpdateChannelMembersRequest(channelId: _channelId, userIds: userIds, mutePeriod: millis));
  }
  /* end_public_function */

  /* begin_public_function 
  id: channel.moderation.unmute_members
  */
  Future unmuteMembers(List<String> userIds) {
    return serviceLocator<ChannelMemberMuteUsecase>()
        .get(UpdateChannelMembersRequest(channelId: _channelId, userIds: userIds, mutePeriod: 0));
  }
  /* end_public_function */

  /* begin_public_function 
  id: channel.moderation.ban_members
  */
  Future banMembers(List<String> userIds) {
    return serviceLocator<ChannelMemberBanUsecase>()
        .get(UpdateChannelMembersRequest(channelId: _channelId, userIds: userIds));
  }
  /* end_public_function */

  /* begin_public_function 
  id: channel.moderation.unban_members
  */
  Future unbanMembers(List<String> userIds) {
    return serviceLocator<ChannelMemberUnbanUsecase>()
        .get(UpdateChannelMembersRequest(channelId: _channelId, userIds: userIds));
  }
  /* end_public_function */
}
