import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class ChannelMemberRemoveUsecase extends UseCase<dynamic, UpdateChannelMembersRequest> {
  final ChannelMemberRepo channelMemberRepo;

  ChannelMemberRemoveUsecase({required this.channelMemberRepo});

  @override
  Future get(UpdateChannelMembersRequest params) async {
    return channelMemberRepo.removeMember(params);
  }
}
