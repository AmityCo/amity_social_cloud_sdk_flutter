import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/repo/channel_member_repo.dart';

/// [ChannelMemberJoinUsecase]
class ChannelMemberJoinUsecase extends UseCase<void, String> {
  /// Channel Member Repo
  final ChannelMemberRepo channelMemberRepo;

  /// Init [ChannelMemberJoinUsecase]
  ChannelMemberJoinUsecase({required this.channelMemberRepo});

  @override
  Future get(String params) async {
    return await channelMemberRepo.joinChannel(params);
  }

  @override
  Stream listen(String params) {
    throw UnimplementedError();
  }
}
