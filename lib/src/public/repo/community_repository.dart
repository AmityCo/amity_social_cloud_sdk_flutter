import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/model/api_request/community_member_check_request.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/usecase/community/community_get_recommend.dart';
import 'package:amity_sdk/src/domain/usecase/community/community_get_trending.dart';
import 'package:amity_sdk/src/domain/usecase/community/member/community_member_get_usecase.dart';

class CommunityRepository {
  CommunityCreatorBuilder createCommunity(String displayName) {
    return CommunityCreatorBuilder(serviceLocator(), displayName);
  }

  CommunityUpdaterBuilder updateCommunity(String communityId) {
    return CommunityUpdaterBuilder(serviceLocator(), communityId);
  }

  CommunityGetQueryBuilder getCommunities() {
    return CommunityGetQueryBuilder(useCase: serviceLocator());
  }

  Future<AmityCommunity> getCommunity(String communityId) {
    return serviceLocator<CommunityGetUseCase>().get(communityId);
  }

  Future deleteCommunity(String communityId) {
    return serviceLocator<CommunityDeleteUseCase>().get(communityId);
  }

  Future joinCommunity(String communityId) {
    return serviceLocator<CommunityMemberJoinUsecase>().get(communityId);
  }

  Future leaveCommunity(String communityId) {
    return serviceLocator<CommunityMemberLeaveUsecase>().get(communityId);
  }

  Future<List<AmityCommunity>> getTrendingCommunities() {
    final optionsRequest = OptionsRequest(limit: 5);
    return serviceLocator<CommunityGetTrendingUseCase>().get(optionsRequest);
  }

  Future<List<AmityCommunity>> getRecommendedCommunities(
      {String? token, int? limit}) {
    final optionsRequest = OptionsRequest(limit: 5);
    return serviceLocator<CommunityGetRecommendedUseCase>().get(optionsRequest);
  }

  AmityCommunityParticipation membership(String communityId) {
    return AmityCommunityParticipation(communityId);
  }

  AmityCommunityModeration moderation(String communityId) {
    return AmityCommunityModeration(communityId);
  }

  /// Get User Roles for the Community
  Future<List<String>> _getUserRoles(String communityId, String userId) async {
    AmityCommunityMember amityCommunityMember =
        await serviceLocator<CommunityMemberGetUsecase>().get(
            CommunityMemberPermissionCheckRequest(
                communityId: communityId,
                userId: userId,
                permission: AmityPermission.BAN_USER));
    return Future.value(amityCommunityMember.roles);
  }

  /// Get Current logged in User Roles for the Community
  Future<List<String>> getCurentUserRoles(String communityId) async {
    return _getUserRoles(communityId, AmityCoreClient.getUserId());
  }
}
