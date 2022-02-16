import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/data/data_source/local/db_adapter/follow_info_db_adapter.dart';
import 'package:amity_sdk/domain/domain.dart';

class FollowRepoImpl extends FollowRepo {
  final FollowWApiInterface followWApiInterface;
  final FollowInfoDbAdapter followInfoDbAdapter;
  FollowRepoImpl(
      {required this.followWApiInterface, required this.followInfoDbAdapter});

  @override
  Future<void> accpet(String userId) async {
    //follow response <-> follow hive entity <-> amity follow relationships
    final data = await followWApiInterface.accpet(userId);
    // final followHiveEntities = data.convertToFollowHiveEntity();
    // final amityFollowRelationships = followHiveEntities.
    // throw UnimplementedError();
    return;
  }

  @override
  Future<void> decline(String userId) async {
    final data = await followWApiInterface.decline(userId);
    return;
  }

  @override
  Future<AmityFollowStatus> follow(String userId) async {
    final data = await followWApiInterface.follow(userId);
    final followStatus = data.follows[0].status;
    return AmityFollowStatus.values.firstWhere(
        (element) => element.value == followStatus,
        orElse: (() => AmityFollowStatus.NONE));
  }

  @override
  Future<void> unfollow(String userId) async {
    final data = await followWApiInterface.unfollow(userId);
    return;
  }

  @override
  Future<AmityUserFollowInfo> getFollowInfo(String userId) async {
    final data = await followWApiInterface.getFollowInfo(userId);
    final followInfoHiveEntiry = data.convertToFollowInfoHiveEntity();
    await followInfoDbAdapter.saveFollowInfo(followInfoHiveEntiry);
    final amityUserFollowInfo =
        followInfoHiveEntiry.convertToAmityUserFollowInfo();
    return amityUserFollowInfo;
  }

  @override
  Future<List<AmityFollowRelationship>> getFollower(String userId) async {
    throw UnimplementedError();
  }

  @override
  Future<List<AmityFollowRelationship>> getFollowing(String userId) async {
    throw UnimplementedError();
  }

  @override
  Future<AmityUserFollowInfo> getMyFollowInfo() async {
    final data = await followWApiInterface.getMyFollowInfo();
    final followInfoHiveEntiry = data.convertToFollowInfoHiveEntity();
    await followInfoDbAdapter.saveFollowInfo(followInfoHiveEntiry);
    final amityUserFollowInfo =
        followInfoHiveEntiry.convertToAmityUserFollowInfo();
    return amityUserFollowInfo;
  }

  @override
  Future<List<AmityFollowRelationship>> getMyFollower() async {
    throw UnimplementedError();
  }

  @override
  Future<List<AmityFollowRelationship>> getMyFollowing() async {
    throw UnimplementedError();
  }
}
