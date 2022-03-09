import 'package:amity_sdk/core/model/api_request/create_community_request.dart';
import 'package:amity_sdk/data/response/create_community_response.dart';


abstract class CommunityApiInterface {
  Future<CreateCommunityResponse> getCommunityById(String communityId);
  Future<CreateCommunityResponse> createCommunity(
      CreateCommunityRequest request);
}
