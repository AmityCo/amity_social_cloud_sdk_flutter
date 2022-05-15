import 'package:amity_sdk/src/core/model/api_request/create_community_request.dart';
import 'package:amity_sdk/src/domain/model/community/amity_community.dart';

abstract class CommunityRepo {
  Future<AmityCommunity> createCommunity(CreateCommunityRequest request);
  Future<AmityCommunity> getCommunityById(String communityId);

  Future<AmityCommunity> getCommunity(String communityId);
  Future deleteCommunity(String communityId);
  Future<AmityCommunity> updateCommunity(CreateCommunityRequest request);
}
