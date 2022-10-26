import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';

abstract class ChannelModerationRepo {
  Future<CreateChannelResponse> addRole(UpdateChannelRoleRequest request);
  Future<CreateChannelResponse> removeRole(UpdateChannelRoleRequest request);
}
