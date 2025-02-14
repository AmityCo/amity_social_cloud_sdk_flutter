import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [ChannelRepo]
abstract class ChannelRepo {
  /// Get Channel Query
  Future<PageListData<List<AmityChannel>, String>> getChannelQuery(
      GetChannelRequest request);

  /// Get Channel By ID
  Future<AmityChannel> getChannelById(String channelId);

  /// Create Channel
  Future<AmityChannel> createChannel(CreateChannelRequest request);

  /// Get Channel
  Future<AmityChannel> getChannel(String channelId);

  /// Delete Channel
  Future deleteChannel(String channelId);

  /// Update Channel
  Future<AmityChannel> updateChannel(CreateChannelRequest request);

  /// Mute Channel
  Future muteChannel(UpdateChannelMembersRequest request);

  /// listen to channels stream
  Stream<List<AmityChannel>> listenChannels(
      RequestBuilder<GetChannelRequest> request);

  /// Get Channels
  List<ChannelHiveEntity> getChannelEntities(
      RequestBuilder<GetChannelRequest> request);

  /// Get Channel Entity from cache
  ChannelHiveEntity? getChannelEntity(String channelId);

  /// Save Channel Entity
  Future saveChannelEntity(ChannelHiveEntity data);

  /// Has Channel in Local
  bool hasInLocal(String channelId);

  Future<List<AmityChannel>> getChannels(List<String> channelIds);

  Future<String?> getMessagePreviewId(String channelId);
}
