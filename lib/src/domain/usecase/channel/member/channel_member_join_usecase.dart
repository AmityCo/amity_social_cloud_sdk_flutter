import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [ChannelMemberJoinUsecase]
class ChannelMemberJoinUsecase extends UseCase<dynamic, String> {
  /// Channel Member Repo
  final ChannelMemberRepo channelMemberRepo;

  /// Channel Composer Usecase
  final ChannelComposerUsecase channelComposerUsecase;

  /// Init [ChannelMemberJoinUsecase]
  ChannelMemberJoinUsecase({required this.channelMemberRepo, required this.channelComposerUsecase});

  @override
  Future<dynamic> get(String params) async {
    return channelMemberRepo.joinChannel(params);
  }
}
