import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/model/api_request/community_member_check_request.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommunityMemberGetUsecase extends UseCase<AmityCommunityMember,
    CommunityMemberPermissionCheckRequest> {
  final CommunityMemberRepo communityMemberRepo;

  CommunityMemberGetUsecase({required this.communityMemberRepo});

  @override
  Future<AmityCommunityMember> get(
      CommunityMemberPermissionCheckRequest params) async {
    final amityMember =
        await communityMemberRepo.getMember(params.communityId, params.userId);
    return amityMember;
  }

  @override
  Stream<AmityCommunityMember> listen(
      CommunityMemberPermissionCheckRequest params) {
    throw UnimplementedError();
  }
}
