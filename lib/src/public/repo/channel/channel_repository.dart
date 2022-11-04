import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

/// Channel Repository
class ChannelRepository {
  /// Get the [AmityChannel] by channel Id
  Future<AmityChannel> getChannel(String channelId) {
    return serviceLocator<ChannelGetUseCase>().get(channelId);
  }

  /// Get the [AmityChannel] by channel Id
  GetChannelQueryBuilder getChannels() {
    return GetChannelQueryBuilder(serviceLocator());
  }

  /// Join the channel
  Future<AmityChannel> joinChannel(String channeld) {
    return serviceLocator<ChannelMemberJoinUsecase>().get(channeld);
  }

  /// Leave the channel
  Future leaveChannel(String channelId) {
    return serviceLocator<ChannelMemberLeaveUsecase>().get(channelId);
  }

  /// Add Member to channel
  Future addMembers(String channelId, List<String> userIds) {
    return serviceLocator<ChannelMemberAddUsecase>().get(
        UpdateChannelMembersRequest(channelId: channelId, userIds: userIds));
  }

  /// Remove member to channel
  Future removeMembers(String channelId, List<String> userIds) {
    return serviceLocator<ChannelMemberRemoveUsecase>().get(
        UpdateChannelMembersRequest(channelId: channelId, userIds: userIds));
  }

  /// Membership Repo
  ChannelParticipationRepository membership(String channelId) {
    return serviceLocator<ChannelParticipationRepository>()
        .channelId(channelId);
  }

  /// Channel Moderation Repo
  ChannelModerationRepository moderation(String channelId) {
    return serviceLocator<ChannelModerationRepository>().channelId(channelId);
  }
}
