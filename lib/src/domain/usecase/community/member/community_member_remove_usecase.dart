import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/model/api_request/update_community_members_request.dart';
import 'package:amity_sdk/src/domain/repo/community_member_repo.dart';

class CommunityMemberRemoveUsecase
    extends UseCase<void, UpdateCommunityMembersRequest> {
  final CommunityMemberRepo communityMemberRepo;

  CommunityMemberRemoveUsecase({required this.communityMemberRepo});

  @override
  Future get(UpdateCommunityMembersRequest params) async {
    await communityMemberRepo.removeMember(params);
  }

  @override
  Stream listen(UpdateCommunityMembersRequest params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
