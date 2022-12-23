import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [ChannelMemberSearchUsecase]
class ChannelMemberSearchUsecase extends UseCase<
    PageListData<List<AmityChannelMember>, String>,
    GetChannelMembersRequestV4> {
  /// Channel Member Repo
  final ChannelMemberRepo channelMemberRepo;

  /// Channel Composer Usecase
  final ChannelMemberComposerUsecase channelMemberComposerUsecase;

  /// Init [ChannelMemberSearchUsecase]
  ChannelMemberSearchUsecase(
      {required this.channelMemberRepo,
      required this.channelMemberComposerUsecase});

  @override
  Future<PageListData<List<AmityChannelMember>, String>> get(
      GetChannelMembersRequestV4 params) async {
    final amityChannelMembers = await channelMemberRepo.searchMembers(params);
    final amityComposedChannelMembers =
        await Stream.fromIterable(amityChannelMembers.data)
            .asyncMap<AmityChannelMember>(
                (event) async => await channelMemberComposerUsecase.get(event))
            .toList();
    return amityChannelMembers.withItem1(amityComposedChannelMembers);
  }
}
