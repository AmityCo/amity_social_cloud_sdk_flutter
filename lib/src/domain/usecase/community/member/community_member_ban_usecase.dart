import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/repo/community_member_repo.dart';

class CommunityMemberBanUsecase extends UseCase<void, UpdateCommunityMembersRequest> {
  final CommunityMemberRepo communityMemberRepo;

  CommunityMemberBanUsecase({required this.communityMemberRepo});

  @override
  Future get(UpdateCommunityMembersRequest params) async {
    return communityMemberRepo.banMember(params);
  }
}
