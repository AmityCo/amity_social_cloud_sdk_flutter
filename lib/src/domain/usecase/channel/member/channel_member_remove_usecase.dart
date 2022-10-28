import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class ChannelMemberRemoveUsecase
    extends UseCase<void, UpdateChannelMembersRequest> {
  final ChannelMemberRepo channelMemberRepo;

  ChannelMemberRemoveUsecase({required this.channelMemberRepo});

  @override
  Future get(UpdateChannelMembersRequest params) async {
    return await channelMemberRepo.removeMember(params);
  }
}
