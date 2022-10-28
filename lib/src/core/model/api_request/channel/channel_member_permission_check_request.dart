import 'package:amity_sdk/src/core/core.dart';

class ChannelMemberPermissionCheckRequest {
  String channelId;
  final String userId;
  final AmityPermission permission;

  ChannelMemberPermissionCheckRequest(
      {required this.channelId,
      required this.userId,
      required this.permission});
}
