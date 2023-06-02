import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

/// Community Repository for all community related operation
class AmityCommunityRepository {
  /* begin_public_function 
  id: community.create
  api_style: async
  */
  ///Create Community
  CommunityCreatorBuilder createCommunity(String displayName) {
    return CommunityCreatorBuilder(serviceLocator(), displayName);
  }
  /* end_public_function */

  /* begin_public_function 
  id: community.update
  api_style: async
  */
  /// Update Community
  CommunityUpdaterBuilder updateCommunity(String communityId) {
    return CommunityUpdaterBuilder(serviceLocator(), communityId);
  }
  /* end_public_function */

  /* begin_public_function 
  id: community.query
  */
  /// Get Communities with filter
  CommunityGetQueryBuilder getCommunities() {
    return CommunityGetQueryBuilder(useCase: serviceLocator());
  }
  /* end_public_function */

  /* begin_public_function 
  id: community.category.query
  */
  /// Get Community Categories
  CommunityCategoryGetQueryBuilder getCategories() {
    return CommunityCategoryGetQueryBuilder(usecase: serviceLocator());
  }
  /* end_public_function */

  /* begin_public_function 
  id: community.get
  */
  /// Get Community with Community Id
  Future<AmityCommunity> getCommunity(String communityId) {
    return serviceLocator<CommunityGetUseCase>().get(communityId);
  }
  /* end_public_function */

  /* begin_public_function 
  id: community.delete
  */
  /// Delete Community with community Id
  Future deleteCommunity(String communityId) {
    return serviceLocator<CommunityDeleteUseCase>().get(communityId);
  }
  /* end_public_function */

  /* begin_public_function 
  id: community.join
  */
  /// join the community with community Id
  Future joinCommunity(String communityId) {
    return serviceLocator<CommunityMemberJoinUsecase>().get(communityId);
  }
  /* end_public_function */

  /* begin_public_function 
  id: community.leave
  */
  /// unfollow/leave the community with community Id
  Future leaveCommunity(String communityId) {
    return serviceLocator<CommunityMemberLeaveUsecase>().get(communityId);
  }
  /* end_public_function */

  /* begin_public_function 
  id: community.query.trending_communities
  */
  /// Get trading community for the network
  Future<List<AmityCommunity>> getTrendingCommunities() {
    final optionsRequest = OptionsRequest(limit: 5);
    return serviceLocator<CommunityGetTrendingUseCase>().get(optionsRequest);
  }
  /* end_public_function */

  /* begin_public_function 
  id: community.query.recommended_communities
  */
  /// Get the Recommended Community for the network
  Future<List<AmityCommunity>> getRecommendedCommunities({String? token, int? limit}) {
    final optionsRequest = OptionsRequest(limit: 5);
    return serviceLocator<CommunityGetRecommendedUseCase>().get(optionsRequest);
  }
  /* end_public_function */

  /// Get the member list for the community Id
  AmityCommunityParticipation membership(String communityId) {
    return AmityCommunityParticipation(communityId);
  }

  /// Community Moderation repo for moderation related operation
  AmityCommunityModeration moderation(String communityId) {
    return AmityCommunityModeration(communityId);
  }

  /// Get User Roles for the Community
  Future<List<String>> _getUserRoles(String communityId, String userId) async {
    AmityCommunityMember amityCommunityMember = await serviceLocator<CommunityMemberGetUsecase>().get(
        CommunityMemberPermissionCheckRequest(
            communityId: communityId, userId: userId, permission: AmityPermission.BAN_USER));
    return Future.value(amityCommunityMember.roles);
  }

  /// Get Current logged in User Roles for the Community
  Future<List<String>> getCurentUserRoles(String communityId) async {
    return _getUserRoles(communityId, AmityCoreClient.getUserId());
  }
}
