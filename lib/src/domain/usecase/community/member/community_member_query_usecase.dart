import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommunityMemberQueryUsecase extends UseCase<
    Tuple2<List<AmityCommunityMember>, String>, GetCommunityMembersRequest> {
  final CommunityMemberRepo communityMemberRepo;
  final CommunityMemberComposerUsecase communityMemberComposerUsecase;

  CommunityMemberQueryUsecase(
      {required this.communityMemberRepo,
      required this.communityMemberComposerUsecase});

  @override
  Future<Tuple2<List<AmityCommunityMember>, String>> get(
      GetCommunityMembersRequest params) async {
    final amityCommunityMemberTuple =
        await communityMemberRepo.queryMembers(params);
    final amityComposedCommunityMember =
        await Stream.fromIterable(amityCommunityMemberTuple.item1)
            .asyncMap((event) => communityMemberComposerUsecase.get(event))
            .toList();
    return amityCommunityMemberTuple.withItem1(amityComposedCommunityMember);
  }

  @override
  Stream<Tuple2<List<AmityCommunityMember>, String>> listen(
      GetCommunityMembersRequest params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
