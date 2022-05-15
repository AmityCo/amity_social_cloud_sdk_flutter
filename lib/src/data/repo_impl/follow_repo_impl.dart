// ignore_for_file: unused_local_variable

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class FollowRepoImpl extends FollowRepo {
  final FollowApiInterface followWApiInterface;
  final FollowInfoDbAdapter followInfoDbAdapter;
  final FollowDbAdapter followDbAdapter;
  final UserDbAdapter userDbAdapter;
  final FileDbAdapter fileDbAdapter;

  FollowRepoImpl({
    required this.followWApiInterface,
    required this.followInfoDbAdapter,
    required this.followDbAdapter,
    required this.userDbAdapter,
    required this.fileDbAdapter,
  });

  @override
  Future<void> accpet(String userId) async {
    final data = await followWApiInterface.accpet(userId);
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
    final data = await followWApiInterface.getFollower(userId);

    //Covert to Follow Hive Entity
    List<FollowHiveEntity> followHiveEntitys =
        data.follows.map((e) => e.convertFollowHiveEntity()).toList();

    //Covert to User Hive Entity
    List<UserHiveEntity> userHiveEntitys =
        data.users!.map((e) => e.convertToUserHiveEntity()).toList();

    //Covert to File Hive Entity
    List<FileHiveEntity> fileHiveEntitys =
        data.files!.map((e) => e.convertToFileHiveEntity()).toList();

    //Save Follow Hive Entity
    for (var e in followHiveEntitys) {
      await followDbAdapter.saveFollowEntity(e);
    }

    //Save User Hive Entity
    for (var e in userHiveEntitys) {
      await userDbAdapter.saveUserEntity(e);
    }

    //Save File Hive Entity
    for (var e in fileHiveEntitys) {
      await fileDbAdapter.saveFileEntity(e);
    }

    return followHiveEntitys
        .map((e) => e.convertToAmityFollowRelationship())
        .toList();
  }

  @override
  Future<List<AmityFollowRelationship>> getFollowing(String userId) async {
    final data = await followWApiInterface.getFollowing(userId);

    //Covert to Follow Hive Entity
    List<FollowHiveEntity> followHiveEntitys =
        data.follows.map((e) => e.convertFollowHiveEntity()).toList();

    //Covert to User Hive Entity
    List<UserHiveEntity> userHiveEntitys =
        data.users!.map((e) => e.convertToUserHiveEntity()).toList();

    //Covert to File Hive Entity
    List<FileHiveEntity> fileHiveEntitys =
        data.files!.map((e) => e.convertToFileHiveEntity()).toList();

    //Save Follow Hive Entity
    for (var e in followHiveEntitys) {
      await followDbAdapter.saveFollowEntity(e);
    }

    //Save User Hive Entity
    for (var e in userHiveEntitys) {
      await userDbAdapter.saveUserEntity(e);
    }

    //Save File Hive Entity
    for (var e in fileHiveEntitys) {
      await fileDbAdapter.saveFileEntity(e);
    }

    return followHiveEntitys
        .map((e) => e.convertToAmityFollowRelationship())
        .toList();
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
    final data = await followWApiInterface.getMyFollower();

    //Covert to Follow Hive Entity
    List<FollowHiveEntity> followHiveEntitys =
        data.follows.map((e) => e.convertFollowHiveEntity()).toList();

    //Covert to User Hive Entity
    List<UserHiveEntity> userHiveEntitys =
        data.users!.map((e) => e.convertToUserHiveEntity()).toList();

    //Covert to File Hive Entity
    List<FileHiveEntity> fileHiveEntitys =
        data.files!.map((e) => e.convertToFileHiveEntity()).toList();

    //Save Follow Hive Entity
    for (var e in followHiveEntitys) {
      await followDbAdapter.saveFollowEntity(e);
    }

    //Save User Hive Entity
    for (var e in userHiveEntitys) {
      await userDbAdapter.saveUserEntity(e);
    }

    //Save File Hive Entity
    for (var e in fileHiveEntitys) {
      await fileDbAdapter.saveFileEntity(e);
    }

    return followHiveEntitys
        .map((e) => e.convertToAmityFollowRelationship())
        .toList();
  }

  @override
  Future<List<AmityFollowRelationship>> getMyFollowing() async {
    final data = await followWApiInterface.getMyFollowing();

    //Covert to Follow Hive Entity
    List<FollowHiveEntity> followHiveEntitys =
        data.follows.map((e) => e.convertFollowHiveEntity()).toList();

    //Covert to User Hive Entity
    List<UserHiveEntity> userHiveEntitys =
        data.users!.map((e) => e.convertToUserHiveEntity()).toList();

    //Covert to File Hive Entity
    List<FileHiveEntity> fileHiveEntitys =
        data.files!.map((e) => e.convertToFileHiveEntity()).toList();

    //Save Follow Hive Entity
    for (var e in followHiveEntitys) {
      await followDbAdapter.saveFollowEntity(e);
    }

    //Save User Hive Entity
    for (var e in userHiveEntitys) {
      await userDbAdapter.saveUserEntity(e);
    }

    //Save File Hive Entity
    for (var e in fileHiveEntitys) {
      await fileDbAdapter.saveFileEntity(e);
    }

    return followHiveEntitys
        .map((e) => e.convertToAmityFollowRelationship())
        .toList();
  }
}
