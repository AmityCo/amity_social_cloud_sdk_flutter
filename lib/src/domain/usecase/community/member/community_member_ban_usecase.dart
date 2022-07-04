import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/model/api_request/update_community_members_request.dart';
import 'package:amity_sdk/src/domain/repo/community_member_repo.dart';

class CommunityMemberBanUsecase
    extends UseCase<void, UpdateCommunityMembersRequest> {
  final CommunityMemberRepo communityMemberRepo;

  CommunityMemberBanUsecase({required this.communityMemberRepo});

  @override
  Future get(UpdateCommunityMembersRequest params) async {
    return await communityMemberRepo.banMember(params);
  }

  @override
  Stream listen(UpdateCommunityMembersRequest params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
