import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommunityMemberAddUsecase
    extends UseCase<List<AmityCommunityMember>, UpdateCommunityMembersRequest> {
  final CommunityMemberRepo communityMemberRepo;
  final CommunityMemberComposerUsecase communityMemberComposerUsecase;

  CommunityMemberAddUsecase(
      {required this.communityMemberRepo,
      required this.communityMemberComposerUsecase});

  @override
  Future<List<AmityCommunityMember>> get(
      UpdateCommunityMembersRequest params) async {
    await communityMemberRepo.addMember(params);
    final communityMembers = await Stream.fromIterable(params.userIds)
        .asyncMap(
            (event) => communityMemberRepo.getMember(params.communityId, event))
        .asyncMap((event) => communityMemberComposerUsecase.get(event))
        .toList();
    return communityMembers;
  }

  @override
  Stream<List<AmityCommunityMember>> listen(
      UpdateCommunityMembersRequest params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
