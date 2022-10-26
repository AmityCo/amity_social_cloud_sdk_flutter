import 'package:amity_sdk/src/core/model/api_request/channel/update_channel_role_request.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class ChannelModerationRepoImpl extends ChannelModerationRepo {
  /// Channel Member Api Interface
  final ChannelMemberApiInterface channelMemberApiInterface;

  ///Db Adapter
  final DbAdapterRepo commonDbAdapter;

  /// Init [ChannelModerationRepoImpl]
  ChannelModerationRepoImpl(
      {required this.channelMemberApiInterface, required this.commonDbAdapter});
  @override
  Future<CreateChannelResponse> addRole(
      UpdateChannelRoleRequest request) async {
    final data = await channelMemberApiInterface.addRole(request);
    final amityChannel = await data.saveToDb<AmityChannel>(commonDbAdapter);
    return amityChannel.first;
  }

  @override
  Future<CreateChannelResponse> removeRole(
      UpdateChannelRoleRequest request) async {
    final data = await channelMemberApiInterface.removeRole(request);
    final amityChannel = await data.saveToDb<AmityChannel>(commonDbAdapter);
    return amityChannel.first;
  }
}
