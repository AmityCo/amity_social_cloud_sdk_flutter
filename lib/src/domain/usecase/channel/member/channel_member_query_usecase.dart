import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [ChannelMemberQueryUsecase]
class ChannelMemberQueryUsecase extends UseCase<
    PageListData<List<AmityChannelMember>, String>, GetChannelMembersRequest> {
  /// Channel Member Repo
  final ChannelMemberRepo channelMemberRepo;

  /// Channel Composer Usecase
  final ChannelMemberComposerUsecase channelMemberComposerUsecase;

  /// Init [ChannelMemberQueryUsecase]
  ChannelMemberQueryUsecase(
      {required this.channelMemberRepo,
      required this.channelMemberComposerUsecase});

  @override
  Future<PageListData<List<AmityChannelMember>, String>> get(
      GetChannelMembersRequest params) async {
    // return await channelMemberRepo.queryMembers(params);
    final amityChannelMembers = await channelMemberRepo.queryMembers(params);
    final amityComposedChannelMembers =
        await Stream.fromIterable(amityChannelMembers.data)
            .asyncMap<AmityChannelMember>(
                (event) async => await channelMemberComposerUsecase.get(event))
            .toList();
    return amityChannelMembers.withItem1(amityComposedChannelMembers);
  }
}
