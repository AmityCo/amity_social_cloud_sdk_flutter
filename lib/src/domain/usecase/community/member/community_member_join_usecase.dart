import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/repo/community_member_repo.dart';

class CommunityMemberJoinUsecase extends UseCase<void, String> {
  final CommunityMemberRepo communityMemberRepo;

  CommunityMemberJoinUsecase({required this.communityMemberRepo});

  @override
  Future get(String params) async {
    return await communityMemberRepo.joinCommunity(params);
  }

  @override
  Stream listen(String params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
