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

  Future muteMembers(List<String> userIds,
      {Duration timeout = const Duration(minutes: 10)}) {
    return serviceLocator<ChannelMemberMuteUsecase>().get(
        UpdateChannelMembersRequest(
            channelId: _channelId,
            userIds: userIds,
            mutePeriod: timeout.inMilliseconds));
  }

  // Future unmuteMembers(List<String> userIds) {
  //     return UnMuteUsersChannelUseCase().execute(channelId, userIds);
  // }

  // Future muteChannel(timeout: Duration) {
  //     return MuteChannelUseCase().execute(channelId, timeout);
  // }

  // Future unmuteChannel() {
  //     return UnMuteChannelUseCase().execute(channelId);
  // }

  // Future banMembers(List<String> userIds) {
  //     return BanUsersChannelUseCase().execute(channelId, userIds);
  // }

  // Future unbanMembers(List<String> userIds) {
  //     return UnBanUsersChannelUseCase().execute(channelId, userIds);
  // }

}
