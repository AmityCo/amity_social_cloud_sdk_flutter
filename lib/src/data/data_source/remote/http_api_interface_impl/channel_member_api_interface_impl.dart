import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';

/// [ChannelMemberApiInterfaceImpl]
class ChannelMemberApiInterfaceImpl extends ChannelMemberApiInterface {
  /// init [ChannelMemberApiInterfaceImpl]
  ChannelMemberApiInterfaceImpl({required this.httpApiClient});

  /// Http Client
  final HttpApiClient httpApiClient;

  @override
  Future<CreateChannelResponse> addMember(UpdateChannelMembersRequest request) {
    // TODO: implement addMember
    throw UnimplementedError();
  }

  @override
  Future<CreateChannelResponse> addRole(UpdateChannelRoleRequest request) {
    // TODO: implement addRole
    throw UnimplementedError();
  }

  @override
  Future<CreateChannelResponse> banMember(UpdateChannelMembersRequest request) {
    // TODO: implement banMember
    throw UnimplementedError();
  }

  @override
  Future<CreateChannelResponse> getChannelMembers(
      GetChannelMembersRequest request) {
    // TODO: implement getChannelMembers
    throw UnimplementedError();
  }

  @override
  Future<CreateChannelResponse> joinChannel(String channelId) {
    // TODO: implement joinChannel
    throw UnimplementedError();
  }

  @override
  Future<CreateChannelResponse> leaveChannel(String channelId) {
    // TODO: implement leaveChannel
    throw UnimplementedError();
  }

  @override
  Future<CreateChannelResponse> removeMember(
      UpdateChannelMembersRequest request) {
    // TODO: implement removeMember
    throw UnimplementedError();
  }

  @override
  Future<CreateChannelResponse> removeRole(UpdateChannelRoleRequest request) {
    // TODO: implement removeRole
    throw UnimplementedError();
  }

  @override
  Future<CreateChannelResponse> unbanMember(
      UpdateChannelMembersRequest request) {
    // TODO: implement unbanMember
    throw UnimplementedError();
  }
}
