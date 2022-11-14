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

  Future addRole(String role, List<String> userIds) {
    return serviceLocator<ChannelMemberAddRoleUsecase>().get(
        UpdateChannelRoleRequest(
            channelId: _channelId, role: role, userIds: userIds));
  }

  Future removeRole(String role, List<String> userIds) {
    return serviceLocator<ChannelMemberRemoveRoleUsecase>().get(
        UpdateChannelRoleRequest(
            channelId: _channelId, role: role, userIds: userIds));
  }

  Future muteMembers(List<String> userIds, {int millis = 600000}) {
    return serviceLocator<ChannelMemberMuteUsecase>().get(
        UpdateChannelMembersRequest(
            channelId: _channelId, userIds: userIds, mutePeriod: millis));
  }

  Future unmuteMembers(List<String> userIds) {
    return serviceLocator<ChannelMemberMuteUsecase>().get(
        UpdateChannelMembersRequest(
            channelId: _channelId, userIds: userIds, mutePeriod: 0));
  }

  Future banMembers(List<String> userIds) {
    return serviceLocator<ChannelMemberBanUsecase>().get(
        UpdateChannelMembersRequest(channelId: _channelId, userIds: userIds));
  }

  Future unbanMembers(List<String> userIds) {
    return serviceLocator<ChannelMemberUnbanUsecase>().get(
        UpdateChannelMembersRequest(channelId: _channelId, userIds: userIds));
  }
}
