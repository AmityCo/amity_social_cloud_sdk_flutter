import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';

/// Abs Channel API Interface
abstract class ChannelApiInterface {
  /// Get channel Query
  Future<CreateChannelResponse> getChannelQuery(GetChannelRequest request);

  /// Create Channel
  Future<CreateChannelResponse> createChannel(CreateChannelRequest request);

  /// Create Channel
  Future<CreateChannelResponse> createConversationChannel(
      CreateChannelRequest request);

  /// Update Channel
  Future<CreateChannelResponse> updateChannel(CreateChannelRequest request);

  /// Get Channel
  Future<CreateChannelResponse> getChannel(String channelId);

  /// Delete Channel

  Future<bool> deleteChannel(String channelId);

  /// Mute Channel
  Future muteChannel(UpdateChannelMembersRequest request);
}
