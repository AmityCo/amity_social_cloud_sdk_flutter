import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/repo/community_member_repo.dart';

class CommunityMemberLeaveUsecase extends UseCase<void, String> {
  final CommunityMemberRepo communityMemberRepo;

  CommunityMemberLeaveUsecase({required this.communityMemberRepo});

  @override
  Future get(String params) async {
    return await communityMemberRepo.leaveCommunity(params);
  }

  @override
  Stream listen(String params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
