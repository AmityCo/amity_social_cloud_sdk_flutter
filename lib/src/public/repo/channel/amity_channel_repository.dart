import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

/// Channel Repository
class AmityChannelRepository {
  /* begin_public_function 
  id: channel.create
  */
  /// Create the [AmityChannel]
  ChannelCreatorTypeSelection createChannel() {
    return ChannelCreatorTypeSelection();
  }
  /* end_public_function */

  /* begin_public_function 
  id: channel.update
  */
  /// Update the [AmityChannel]
  ChannelUpdateBuilder updateChannel(String channelId) {
    return ChannelUpdateBuilder(channelId, serviceLocator());
  }
  /* end_public_function */

  /* begin_public_function 
  id: channel.get
  */
  /// Get the [AmityChannel] by channel Id
  Future<AmityChannel> getChannel(String channelId) {
    return serviceLocator<ChannelGetUseCase>().get(channelId);
  }
  /* end_public_function */

  /* begin_public_function 
  id: channel.query
  */
  /// Get the [AmityChannel] by channel Id
  GetChannelQueryBuilder getChannels() {
    return GetChannelQueryBuilder(serviceLocator());
  }
  /* end_public_function */

  /* begin_public_function 
  id: channel.join
  */
  /// Join the channel
  Future joinChannel(String channeld) {
    return serviceLocator<ChannelMemberJoinUsecase>().get(channeld);
  }
  /* end_public_function */

  /* begin_public_function 
  id: channel.leave
  */
  /// Leave the channel
  Future leaveChannel(String channelId) {
    return serviceLocator<ChannelMemberLeaveUsecase>().get(channelId);
  }
  /* end_public_function */

  /* begin_public_function 
  id: channel.mute
  */
  /// Mute  channel
  Future muteChannel(String channelId, {int millis = 600000}) {
    return serviceLocator<ChannelMuteUsecase>()
        .get(UpdateChannelMembersRequest(channelId: channelId, mutePeriod: millis));
  }
  /* end_public_function */

  /* begin_public_function 
  id: channel.unmute
  */
  /// Unmute  channel
  Future unMuteChannel(String channelId) {
    return serviceLocator<ChannelMuteUsecase>().get(UpdateChannelMembersRequest(channelId: channelId, mutePeriod: 0));
  }
  /* end_public_function */

  /* begin_public_function 
  id: channel.member.add
  */
  /// Add Member to channel
  Future addMembers(String channelId, List<String> userIds) {
    return serviceLocator<ChannelMemberAddUsecase>()
        .get(UpdateChannelMembersRequest(channelId: channelId, userIds: userIds));
  }
  /* end_public_function */

  /* begin_public_function 
  id: channel.member.remove
  */
  /// Remove member to channel
  Future removeMembers(String channelId, List<String> userIds) {
    return serviceLocator<ChannelMemberRemoveUsecase>()
        .get(UpdateChannelMembersRequest(channelId: channelId, userIds: userIds));
  }
  /* end_public_function */

  /// Membership Repo
  AmityChannelParticipation membership(String channelId) {
    return serviceLocator<AmityChannelParticipation>().channelId(channelId);
  }

  /// Channel Moderation Repo
  ChannelModerationRepository moderation(String channelId) {
    return serviceLocator<ChannelModerationRepository>().channelId(channelId);
  }
}
