import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/repo/community_member_repo.dart';

/// [CommunityMemberJoinUsecase]
class CommunityMemberJoinUsecase extends UseCase<void, String> {
  /// Community Member Repo
  final CommunityMemberRepo communityMemberRepo;

  /// init [CommunityMemberJoinUsecase]
  CommunityMemberJoinUsecase({required this.communityMemberRepo});

  @override
  Future get(String params) async {
    return await communityMemberRepo.joinCommunity(params);
  }
}
