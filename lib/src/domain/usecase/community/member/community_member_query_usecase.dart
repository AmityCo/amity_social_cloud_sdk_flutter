import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [CommunityMemberQueryUsecase]
class CommunityMemberQueryUsecase extends UseCase<
    PageListData<List<AmityCommunityMember>, String>,
    GetCommunityMembersRequest> {
  /// Community Member Repo
  final CommunityMemberRepo communityMemberRepo;

  /// Community Member Composer Usecase
  final CommunityMemberComposerUsecase communityMemberComposerUsecase;

  /// Init [CommunityMemberQueryUsecase]
  CommunityMemberQueryUsecase(
      {required this.communityMemberRepo,
      required this.communityMemberComposerUsecase});

  @override
  Future<PageListData<List<AmityCommunityMember>, String>> get(
      GetCommunityMembersRequest params) async {
    final amityCommunityMemberTuple =
        await communityMemberRepo.queryMembers(params);
    final amityComposedCommunityMember =
        await Stream.fromIterable(amityCommunityMemberTuple.data)
            .asyncMap((event) => communityMemberComposerUsecase.get(event))
            .toList();
    return amityCommunityMemberTuple.withItem1(amityComposedCommunityMember);
  }

  @override
  Stream<PageListData<List<AmityCommunityMember>, String>> listen(
      GetCommunityMembersRequest params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
