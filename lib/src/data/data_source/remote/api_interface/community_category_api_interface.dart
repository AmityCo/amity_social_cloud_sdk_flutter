import 'package:amity_sdk/src/core/model/api_request/get_community_category_request.dart';
import 'package:amity_sdk/src/data/data.dart';

abstract class CommunityCategoryApiInterface {
  Future<CreateCommunityResponse> communityCategoryQuery(
      GetCommunityCategoryRequest request);


  Future<CreateCommunityResponse> getCommunityCategory(
      String communityId);
}
