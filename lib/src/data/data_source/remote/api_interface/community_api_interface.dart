import 'package:amity_sdk/src/core/model/api_request/create_community_request.dart';
import 'package:amity_sdk/src/data/response/create_community_response.dart';

abstract class CommunityApiInterface {
  Future<CreateCommunityResponse> createCommunity(
      CreateCommunityRequest request);
  Future<CreateCommunityResponse> updateCommunity(
      CreateCommunityRequest request);
  Future<CreateCommunityResponse> getCommunity(String communityId);
  Future<bool> deleteCommunity(String communityId);
}
