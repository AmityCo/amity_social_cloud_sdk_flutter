import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';
import 'package:amity_sdk/src/public/query_builder/channel/update/channel_update_builder.dart';

/// Channel Repository
class AmityChannelRepository {
  /// Create the [AmityChannel]
  ChannelCreatorTypeSelection createChannel() {
    return ChannelCreatorTypeSelection();
  }

  /// Update the [AmityChannel]
  ChannelUpdateBuilder updateChannel(String channelId) {
    return ChannelUpdateBuilder(channelId, serviceLocator());
  }

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

  /// Mute  channel
  Future muteChannel(String channelId, {int millis = 600000}) {
    return serviceLocator<ChannelMuteUsecase>().get(
        UpdateChannelMembersRequest(channelId: channelId, mutePeriod: millis));
  }

  /// Unmute  channel
  Future unMuteChannel(String channelId) {
    return serviceLocator<ChannelMuteUsecase>()
        .get(UpdateChannelMembersRequest(channelId: channelId, mutePeriod: 0));
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
  AmityChannelParticipation membership(String channelId) {
    return serviceLocator<AmityChannelParticipation>().channelId(channelId);
  }

  /// Channel Moderation Repo
  ChannelModerationRepository moderation(String channelId) {
    return serviceLocator<ChannelModerationRepository>().channelId(channelId);
  }
}
