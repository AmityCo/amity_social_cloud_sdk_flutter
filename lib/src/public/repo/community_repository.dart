import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommunityRepository {
  CommunityCreateQueryBuilder createCommunity(String displayName) {
    return CommunityCreateQueryBuilder(serviceLocator(), displayName);
  }

  CommunityUpdateQueryBuilder updateCommunity(String communityId) {
    return CommunityUpdateQueryBuilder(serviceLocator(), communityId);
  }

  Future<AmityCommunity> getCommunity(String communityId) {
    return serviceLocator<CommunityGetUseCase>().get(communityId);
  }

  Future deleteCommunity(String communityId) {
    return serviceLocator<CommunityDeleteUseCase>().get(communityId);
  }
}
