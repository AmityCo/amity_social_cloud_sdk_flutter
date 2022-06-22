import 'package:amity_sdk/src/core/model/api_request/follow_request.dart';
import 'package:amity_sdk/src/data/data.dart';

abstract class FollowApiInterface {
  Future<FollowResponse> accpet(String userId);
  Future<FollowResponse> decline(String userId);

  Future<FollowResponse> follow(String userId);
  Future<FollowResponse> unfollow(String userId);

  Future<FollowResponse> getMyFollower(FollowRequest request);
  Future<FollowResponse> getMyFollowing(FollowRequest request);
  Future<FollowInfoResponse> getMyFollowInfo();

  Future<FollowResponse> getFollower(FollowRequest request);
  Future<FollowResponse> getFollowing(FollowRequest request);
  Future<FollowInfoResponse> getFollowInfo(String userId);
}
