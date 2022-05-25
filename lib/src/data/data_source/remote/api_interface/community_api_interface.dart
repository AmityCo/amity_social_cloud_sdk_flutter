import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/response/create_community_response.dart';

abstract class CommunityApiInterface {
  Future<CreateCommunityResponse> getCommunityQuery(
      GetCommunityRequest request);
  Future<CreateCommunityResponse> getRecommendedCommunity(
      OptionsRequest request);
  Future<CreateCommunityResponse> getTopTredningCommunity(
      OptionsRequest request);
  Future<CreateCommunityResponse> createCommunity(
      CreateCommunityRequest request);
  Future<CreateCommunityResponse> updateCommunity(
      CreateCommunityRequest request);
  Future<CreateCommunityResponse> getCommunity(String communityId);
  Future<bool> deleteCommunity(String communityId);
}
