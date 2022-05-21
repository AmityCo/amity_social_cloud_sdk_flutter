import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/usecase/community/member/community_member_join_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/community/member/community_member_leave_usecase.dart';
import 'package:amity_sdk/src/public/community/amity_community_participation.dart';
import 'package:amity_sdk/src/public/query_builder/community/community_get_query_builder.dart';

class CommunityRepository {
  CommunityCreateQueryBuilder createCommunity(String displayName) {
    return CommunityCreateQueryBuilder(serviceLocator(), displayName);
  }

  CommunityUpdateQueryBuilder updateCommunity(String communityId) {
    return CommunityUpdateQueryBuilder(serviceLocator(), communityId);
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

  AmityCommunityParticipation membership(String communityId) {
    return AmityCommunityParticipation(communityId: communityId);
  }
}
