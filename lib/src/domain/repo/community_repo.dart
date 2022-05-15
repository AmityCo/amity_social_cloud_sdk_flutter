import 'package:amity_sdk/src/core/model/api_request/create_community_request.dart';
import 'package:amity_sdk/src/domain/model/amity_community.dart';

abstract class CommunityRepo {
  Future<AmityCommunity> createCommunity(CreateCommunityRequest request);
  Future<AmityCommunity> getCommunityById(String communityId);
}
