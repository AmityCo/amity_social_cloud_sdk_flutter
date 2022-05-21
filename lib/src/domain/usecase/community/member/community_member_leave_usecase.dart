import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/repo/community_member_repo.dart';

class CommunityMemberLeaveUsecase extends UseCase<void, String> {
  final CommunityMemberRepo communityMemberRepo;

  CommunityMemberLeaveUsecase({required this.communityMemberRepo});

  @override
  Future get(String communityId) async {
    await communityMemberRepo.leaveCommunity(communityId);
  }

  @override
  Stream listen(String communityId) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
