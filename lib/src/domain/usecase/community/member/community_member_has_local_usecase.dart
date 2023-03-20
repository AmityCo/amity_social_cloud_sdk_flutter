import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommunityMemberHasLocalUsecase
    extends SynchronousUseCase<bool, CommunityMemberPermissionCheckRequest> {
  /// Community Member Repo
  final CommunityMemberRepo communityMemberRepo;

  CommunityMemberHasLocalUsecase({required this.communityMemberRepo});

  @override
  bool get(CommunityMemberPermissionCheckRequest params) {
    return communityMemberRepo.hasLocalCommunity(
        params.communityId, params.userId);
  }
}
