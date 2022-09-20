import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/repo/channel_member_repo.dart';

/// [ChannelMemberJoinUsecase]
class ChannelMemberJoinUsecase extends UseCase<AmityChannel, String> {
  /// Channel Member Repo
  final ChannelMemberRepo channelMemberRepo;

  /// Channel Composer Usecase
  final ChannelComposerUsecase channelComposerUsecase;

  /// Init [ChannelMemberJoinUsecase]
  ChannelMemberJoinUsecase(
      {required this.channelMemberRepo, required this.channelComposerUsecase});

  @override
  Future<AmityChannel> get(String params) async {
    return await channelMemberRepo.joinChannel(params);
  }
}
