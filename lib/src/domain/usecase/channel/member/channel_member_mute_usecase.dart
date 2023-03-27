import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/repo/channel_member_repo.dart';

class ChannelMemberMuteUsecase
    extends UseCase<dynamic, UpdateChannelMembersRequest> {
  final ChannelMemberRepo channelMemberRepo;

  ChannelMemberMuteUsecase({required this.channelMemberRepo});

  @override
  Future get(UpdateChannelMembersRequest params) async {
    return  channelMemberRepo.muteMember(params);
  }
}
