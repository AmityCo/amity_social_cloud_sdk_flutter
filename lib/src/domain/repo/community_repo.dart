import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

abstract class CommunityRepo {
  Future<PageListData<List<AmityCommunity>, String>> getCommunityQuery(
      GetCommunityRequest request);
  Future<List<AmityCommunity>> getRecommendedCommunity(OptionsRequest request);
  Future<List<AmityCommunity>> getTopTrendingCommunity(OptionsRequest request);
  Future<AmityCommunity> createCommunity(CreateCommunityRequest request);
  Future<AmityCommunity> getCommunityById(String communityId);

  Future<AmityCommunity> getCommunity(String communityId);
  Future deleteCommunity(String communityId);
  Future<AmityCommunity> updateCommunity(CreateCommunityRequest request);

  int getPostCount(String targetId , String feedType);

  Future<AmityCommunityCategory?> getCommunityCategoryById(String categoryId);

  /// Has Local Community
  bool hasLocalCommunity(String communityId);
}
