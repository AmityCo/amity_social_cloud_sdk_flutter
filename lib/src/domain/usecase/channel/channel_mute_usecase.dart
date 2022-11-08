import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class ChannelMuteUsecase extends UseCase<void, UpdateChannelMembersRequest> {
  final ChannelRepo channelRepo;

  ChannelMuteUsecase({required this.channelRepo});

  @override
  Future get(UpdateChannelMembersRequest params) async {
    return await channelRepo.muteChannel(params);
  }
}
