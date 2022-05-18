import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';

abstract class CommunityRepo {
  Future<Tuple2<List<AmityCommunity>, String>> getCommunityQuery(
      GetCommunityRequest request);
  Future<Tuple2<List<AmityCommunity>, String>> getRecommendedCommunity(
      OptionsRequest request);
  Future<Tuple2<List<AmityCommunity>, String>> getTopTredningCommunity(
      OptionsRequest request);
  Future<AmityCommunity> createCommunity(CreateCommunityRequest request);
  Future<AmityCommunity> getCommunityById(String communityId);

  Future<AmityCommunity> getCommunity(String communityId);
  Future deleteCommunity(String communityId);
  Future<AmityCommunity> updateCommunity(CreateCommunityRequest request);

  Future<AmityCommunityCategory> getCommunityCategoryById(String categoryId);
}
