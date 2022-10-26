import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/repo/community_member_repo.dart';

/// [CommunityMemberPermissionCheckUsecase]
class CommunityMemberPermissionCheckUsecase
    extends SynchronousUseCase<bool, CommunityMemberPermissionCheckRequest> {
  /// Community Member Repo
  final CommunityMemberRepo communityMemberRepo;

  /// Init [CommunityMemberPermissionCheckUsecase]
  CommunityMemberPermissionCheckUsecase({required this.communityMemberRepo});

  @override
  bool get(CommunityMemberPermissionCheckRequest params) {
    var hasPermission = false;
    try {
      final permissions = communityMemberRepo.getMemberPermission(
          params.communityId, params.userId);
      hasPermission = permissions?.contains(params.permission!.value) ?? false;
    } catch (exception) {
      hasPermission = false;
    }
    return hasPermission;
  }
}
