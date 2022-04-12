import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';

abstract class FollowRepo {
  Future<void> accpet(String userId);

  Future<void> decline(String userId);

  Future<AmityFollowStatus> follow(String userId);

  Future<void> unfollow(String userId);

  Future<AmityUserFollowInfo> getFollowInfo(String userId);

  Future<List<AmityFollowRelationship>> getFollower(String userId);

  Future<List<AmityFollowRelationship>> getFollowing(String userId);

  Future<AmityUserFollowInfo> getMyFollowInfo();

  Future<List<AmityFollowRelationship>> getMyFollower();

  Future<List<AmityFollowRelationship>> getMyFollowing();
}
