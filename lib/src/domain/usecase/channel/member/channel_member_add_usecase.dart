import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class ChannelMemberAddUsecase
    extends UseCase<List<AmityChannelMember>, UpdateChannelMembersRequest> {
  final ChannelMemberRepo channelMemberRepo;
  final ChannelMemberComposerUsecase channelMemberComposerUsecase;

  ChannelMemberAddUsecase(
      {required this.channelMemberRepo,
      required this.channelMemberComposerUsecase});

  @override
  Future<List<AmityChannelMember>> get(
      UpdateChannelMembersRequest params) async {
    final channelMembers = await channelMemberRepo.addMember(params);
    final channelMembersComposed = await Stream.fromIterable(channelMembers)
        // .asyncMap(
        //     (event) => channelMemberRepo.getMember(params.channelId, event))
        .asyncMap((event) => channelMemberComposerUsecase.get(event))
        .toList();
    return channelMembersComposed;
  }
}
