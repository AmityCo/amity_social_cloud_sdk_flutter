import 'package:amity_sdk/core/model/api_request/create_community_request.dart';
import 'package:amity_sdk/domain/model/amity_community.dart';

abstract class CommunityRepo {
  Future<AmityCommunity> createCommunity(CreateCommunityRequest request);
  Future<AmityCommunity> getCommunityById(String communityId);
}
