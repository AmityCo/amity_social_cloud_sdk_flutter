import 'package:amity_sdk/src/data/data.dart';

abstract class FollowApiInterface {
  Future<FollowResponse> accpet(String userId);
  Future<FollowResponse> decline(String userId);

  Future<FollowResponse> follow(String userId);
  Future<FollowResponse> unfollow(String userId);

  Future<FollowResponse> getMyFollower();
  Future<FollowResponse> getMyFollowing();
  Future<FollowInfoResponse> getMyFollowInfo();

  Future<FollowResponse> getFollower(String userId);
  Future<FollowResponse> getFollowing(String userId);
  Future<FollowInfoResponse> getFollowInfo(String userId);
}
