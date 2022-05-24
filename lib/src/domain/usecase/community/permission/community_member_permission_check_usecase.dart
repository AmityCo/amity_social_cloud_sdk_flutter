import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/model/api_request/community_member_check_request.dart';
import 'package:amity_sdk/src/domain/repo/community_member_repo.dart';

class CommunityMemberPermissionCheckUsecase
    extends UseCase<bool, CommunityMemberPermissionCheckRequest> {
  final CommunityMemberRepo communityMemberRepo;

  CommunityMemberPermissionCheckUsecase({required this.communityMemberRepo});

  @override
  Future<bool> get(CommunityMemberPermissionCheckRequest params) {
    final permissions = communityMemberRepo.getMemberPermission(
        params.communityId, params.userId);
    final hasPermission = permissions?.contains(params.permission.value);
    return Future.value(hasPermission);
  }

  @override
  Stream<bool> listen(CommunityMemberPermissionCheckRequest params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
