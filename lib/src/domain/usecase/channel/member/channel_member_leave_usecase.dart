import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/repo/channel_member_repo.dart';

/// [ChannelMemberLeaveUsecase]
class ChannelMemberLeaveUsecase extends UseCase<void, String> {
  /// Channel Member Repo
  final ChannelMemberRepo channelMemberRepo;

  /// Init [ChannelMemberLeaveUsecase]
  ChannelMemberLeaveUsecase({required this.channelMemberRepo});

  @override
  Future get(String params) async {
    return await channelMemberRepo.leaveChannel(params);
  }
}
