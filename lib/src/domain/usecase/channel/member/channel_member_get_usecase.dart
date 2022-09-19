import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/repo/channel_member_repo.dart';

/// [ChannelMemberGetUsecase]
class ChannelMemberGetUsecase
    extends UseCase<AmityChannelMember, GetChannelMembersRequest> {
  /// Channel Member Repo
  final ChannelMemberRepo channelMemberRepo;

  /// Channel Composer Usecase
  final ChannelMemberComposerUsecase channelMemberComposerUsecase;

  /// Init [ChannelMemberGetUsecase]
  ChannelMemberGetUsecase(
      {required this.channelMemberRepo,
      required this.channelMemberComposerUsecase});

  @override
  Future<AmityChannelMember> get(GetChannelMembersRequest params) async {
    final data =
        await channelMemberRepo.getMember(params.channelId, params.memberId!);
    return channelMemberComposerUsecase.get(data);
  }

  @override
  Stream<AmityChannelMember> listen(GetChannelMembersRequest params) {
    throw UnimplementedError();
  }
}
