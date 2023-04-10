import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// Follow Abs Repo for all follow/unfollow operation
abstract class FollowRepo {
  /// Accept the follow request from [userId] (POST Follower)
  Future<AmityFollowStatus> accpet(String userId);

  /// Decline the [userId]follow request or delete the [userId] follower (DELETE follower)
  Future<AmityFollowStatus> decline(String userId);

  /// Follow user (POST Following)
  Future<AmityFollowStatus> follow(String userId);

  /// Unfollow or Cancel follow requst to [userId] (DELETE Following)
  Future<AmityFollowStatus> unfollow(String userId);

  /// Get user [userID] follow info
  Future<AmityUserFollowInfo> getFollowInfo(String userId);

  /// Get user [userID] follow info
  Future updateFollowInfoStatus(String userId, AmityFollowStatus status);

  /// Get user folllowers list
  Future<PageListData<List<AmityFollowRelationship>, String>> getFollower(FollowRequest request);

  /// Get user folllowing list
  Future<PageListData<List<AmityFollowRelationship>, String>> getFollowing(FollowRequest request);

  /// Get current logged user follow info
  Future<AmityMyFollowInfo> getMyFollowInfo();

  /// Get my follower list
  Future<PageListData<List<AmityFollowRelationship>, String>> getMyFollower(FollowRequest request);

  /// Get my following list
  Future<PageListData<List<AmityFollowRelationship>, String>> getMyFollowing(FollowRequest request);
}
