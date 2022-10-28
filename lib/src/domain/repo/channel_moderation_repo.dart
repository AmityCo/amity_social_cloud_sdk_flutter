import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

abstract class ChannelModerationRepo {
  Future<List<AmityChannelMember>> addRole(UpdateChannelRoleRequest request);
  Future<List<AmityChannelMember>> removeRole(UpdateChannelRoleRequest request);
}
