import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/repo/community_member_repo.dart';

class CommunityMemberRemoveRoleUsecase
    extends UseCase<void, UpdateCommunityRoleRequest> {
  final CommunityMemberRepo communityMemberRepo;

  CommunityMemberRemoveRoleUsecase({required this.communityMemberRepo});

  @override
  Future get(UpdateCommunityRoleRequest params) async {
    return await communityMemberRepo.removeRole(params);
  }
}
