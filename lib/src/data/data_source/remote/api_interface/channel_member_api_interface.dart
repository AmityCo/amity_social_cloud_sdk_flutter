import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';

/// [ChannelMemberApiInterface]
abstract class ChannelMemberApiInterface {
  /// Get Channel Member
  Future<CreateChannelResponse> getChannelMembers(
      GetChannelMembersRequest request);

  /// Join Channel
  Future<CreateChannelResponse> joinChannel(String channelId);

  /// Leave Channel
  Future<CreateChannelResponse> leaveChannel(String channelId);

  /// Add memeber to channel
  Future<CreateChannelResponse> addMember(UpdateChannelMembersRequest request);

  /// Remove Member from channel
  Future<CreateChannelResponse> removeMember(
      UpdateChannelMembersRequest request);

  /// Add Role
  Future<CreateChannelResponse> addRole(UpdateChannelRoleRequest request);

  /// Remote Role
  Future<CreateChannelResponse> removeRole(UpdateChannelRoleRequest request);

  /// Ban Member
  Future<CreateChannelResponse> banMember(UpdateChannelMembersRequest request);

  /// Update Member
  Future<CreateChannelResponse> unbanMember(
      UpdateChannelMembersRequest request);
}
