import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [CommunityMemberGetOptionalUsecase]
class CommunityMemberGetOptionalUsecase extends UseCaseWithOptionalReturnValue<AmityCommunityMember,
    CommunityMemberPermissionCheckRequest> {
  /// Community Member Repo
  final CommunityMemberRepo communityMemberRepo;

  /// Init [CommunityMemberGetOptionalUsecase]
  CommunityMemberGetOptionalUsecase({required this.communityMemberRepo});

  @override
  Future<AmityCommunityMember?> get(
      CommunityMemberPermissionCheckRequest params) async {
    final amityMember =
        await communityMemberRepo.getMemberOptional(params.communityId, params.userId);
    return amityMember;
  }
}