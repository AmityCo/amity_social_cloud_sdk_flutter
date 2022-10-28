import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/repo/channel_member_repo.dart';

class ChannelMemberUnbanUsecase
    extends UseCase<void, UpdateChannelMembersRequest> {
  final ChannelMemberRepo channelMemberRepo;

  ChannelMemberUnbanUsecase({required this.channelMemberRepo});

  @override
  Future get(UpdateChannelMembersRequest params) async {
    return await channelMemberRepo.unbanMember(params);
  }
}
