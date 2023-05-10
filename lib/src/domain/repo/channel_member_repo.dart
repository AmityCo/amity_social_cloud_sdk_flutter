import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [ChannelMemberRepo]
abstract class ChannelMemberRepo {
  /// Query Members
  Future<PageListData<List<AmityChannelMember>, String>> queryMembers(GetChannelMembersRequest request);

  /// Search Members
  Future<PageListData<List<AmityChannelMember>, String>> searchMembers(GetChannelMembersRequestV4 request);

  /// Add Member
  Future<List<AmityChannelMember>> addMember(UpdateChannelMembersRequest request);

  /// Remove Member
  Future removeMember(UpdateChannelMembersRequest request);

  /// Join Channel
  Future joinChannel(String id);

  /// Leave Channel
  Future leaveChannel(String id);

  /// Add Role
  Future addRole(UpdateChannelRoleRequest request);

  /// Remove Role
  Future removeRole(UpdateChannelRoleRequest request);

  /// Get Member Permission
  List<String>? getMemberPermission(String id, String userId);

  /// Ban Member
  Future banMember(UpdateChannelMembersRequest request);

  /// Unban Member
  Future unbanMember(UpdateChannelMembersRequest request);

  /// Get Member
  Future<AmityChannelMember> getMember(String id, String userId);

  /// Mute Member
  Future muteMember(UpdateChannelMembersRequest request);
}
