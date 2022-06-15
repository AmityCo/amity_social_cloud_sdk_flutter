import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';

abstract class CommunityRepo {
  Future<Tuple2<List<AmityCommunity>, String>> getCommunityQuery(
      GetCommunityRequest request);
  Future<List<AmityCommunity>> getRecommendedCommunity(OptionsRequest request);
  Future<List<AmityCommunity>> getTopTrendingCommunity(OptionsRequest request);
  Future<AmityCommunity> createCommunity(CreateCommunityRequest request);
  Future<AmityCommunity> getCommunityById(String communityId);

  Future<AmityCommunity> getCommunity(String communityId);
  Future deleteCommunity(String communityId);
  Future<AmityCommunity> updateCommunity(CreateCommunityRequest request);

  Future<AmityCommunityCategory?> getCommunityCategoryById(String categoryId);
}
