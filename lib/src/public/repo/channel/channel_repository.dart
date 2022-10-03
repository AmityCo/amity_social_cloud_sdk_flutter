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

  /// Leave the channel
  ChannelParticipationRepository membership(String channelId) {
    return serviceLocator<ChannelParticipationRepository>()
        .channelId(channelId);
  }
}
