import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/repo/community_member_repo.dart';

class CommunityMemberUnbanUsecase
    extends UseCase<void, UpdateCommunityMembersRequest> {
  final CommunityMemberRepo communityMemberRepo;

  CommunityMemberUnbanUsecase({required this.communityMemberRepo});

  @override
  Future get(UpdateCommunityMembersRequest params) async {
    return await communityMemberRepo.unbanMember(params);
  }
}
