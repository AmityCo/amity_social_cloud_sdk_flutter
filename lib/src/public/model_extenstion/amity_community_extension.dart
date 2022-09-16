import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

/// [AmityCommunityExtension]
extension AmityCommunityExtension on AmityCommunity {
  /// Delete
  Future delete({bool hardDelete = false}) {
    return serviceLocator<CommunityDeleteUseCase>().get(communityId!);
  }

  /// Get User Roles for the Community
  Future<List<String>> _getUserRoles(String userId) async {
    AmityCommunityMember amityCommunityMember =
        await serviceLocator<CommunityMemberGetUsecase>()
            .get(CommunityMemberPermissionCheckRequest(
      communityId: communityId!,
      userId: userId,
    ));
    return Future.value(amityCommunityMember.roles);
  }

  /// Get Current logged in User Roles for the Community
  Future<List<String>> getCurentUserRoles() async {
    return _getUserRoles(AmityCoreClient.getUserId());
  }

  /// Check if the current user have the permisson for the community
  bool hasPermission(AmityPermission permission) {
    return serviceLocator<CommunityMemberPermissionCheckUsecase>().get(
        CommunityMemberPermissionCheckRequest(
            communityId: communityId!,
            userId: AmityCoreClient.getUserId(),
            permission: permission));
  }
}
