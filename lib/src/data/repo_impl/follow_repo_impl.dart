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
  Future<AmityFollowStatus> accpet(String userId) async {
    final data = await followWApiInterface.accpet(userId);

    final follow = data.follows[0];

    //Update the follow
    final followHiveEntity = follow.convertFollowHiveEntity();
    await followDbAdapter.saveFollowEntity(followHiveEntity);

    //Update the follow info
    final followInfoHiveEntity = followInfoDbAdapter.getFollowInfo(userId);
    if (followInfoHiveEntity != null) {
      followInfoHiveEntity.followerCount = (followInfoHiveEntity.followerCount ?? 0) + 1;
      followInfoHiveEntity.status = AmityFollowStatus.ACCEPTED.value;
      await followInfoHiveEntity.save();
    }

    return AmityFollowStatus.values
        .firstWhere((element) => element.value == follow.status, orElse: (() => AmityFollowStatus.NONE));
  }

  @override
  Future<AmityFollowStatus> decline(String userId) async {
    final data = await followWApiInterface.decline(userId);

    final follow = data.follows[0];

    //Update the follow
    final followHiveEntity = follow.convertFollowHiveEntity();
    await followDbAdapter.saveFollowEntity(followHiveEntity);

    //Update the follow info
    final followInfoHiveEntity = followInfoDbAdapter.getFollowInfo(userId);
    if (followInfoHiveEntity != null) {
      followInfoHiveEntity.followerCount = (followInfoHiveEntity.followerCount ?? 0) - 1;
      followInfoHiveEntity.status = AmityFollowStatus.NONE.value;
      await followInfoHiveEntity.save();
    }

    return AmityFollowStatus.values
        .firstWhere((element) => element.value == follow.status, orElse: (() => AmityFollowStatus.NONE));
  }

  @override
  Future<AmityFollowStatus> follow(String userId) async {
    final data = await followWApiInterface.follow(userId);
    final follow = data.follows[0];

    //Update the follow
    final followHiveEntity = follow.convertFollowHiveEntity();
    await followDbAdapter.saveFollowEntity(followHiveEntity);

    if (follow.status == AmityFollowStatus.ACCEPTED.value) {
      //Update the follow info
      final followInfoHiveEntity = followInfoDbAdapter.getFollowInfo(userId);
      if (followInfoHiveEntity != null) {
        followInfoHiveEntity.followerCount = (followInfoHiveEntity.followerCount ?? 0) + 1;
        followInfoHiveEntity.status = AmityFollowStatus.ACCEPTED.value;
        await followInfoHiveEntity.save();
      }
    }

    if (follow.status == AmityFollowStatus.PENDING.value) {
      //Update the follow info
      final followInfoHiveEntity = followInfoDbAdapter.getFollowInfo(userId);
      if (followInfoHiveEntity != null) {
        followInfoHiveEntity.status = AmityFollowStatus.PENDING.value;
        await followInfoHiveEntity.save();
      }
    }

    return AmityFollowStatus.values
        .firstWhere((element) => element.value == follow.status, orElse: (() => AmityFollowStatus.NONE));
  }

  @override
  Future<AmityFollowStatus> unfollow(String userId) async {
    final amityFollowInfo = await getFollowInfo(userId);

    final data = await followWApiInterface.unfollow(userId);
    final follow = data.follows[0];

    //Update the follow
    final followHiveEntity = follow.convertFollowHiveEntity();
    await followDbAdapter.saveFollowEntity(followHiveEntity);

    if (amityFollowInfo.status == AmityFollowStatus.ACCEPTED) {
      //Update the follow info
      final followInfoHiveEntity = followInfoDbAdapter.getFollowInfo(userId);
      if (followInfoHiveEntity != null) {
        followInfoHiveEntity.followerCount = (followInfoHiveEntity.followerCount ?? 0) - 1;
        followInfoHiveEntity.status = AmityFollowStatus.NONE.value;
        followInfoHiveEntity.save();
      }
    }

    if (amityFollowInfo.status == AmityFollowStatus.PENDING) {
      //Update the follow info
      final followInfoHiveEntity = followInfoDbAdapter.getFollowInfo(userId);
      if (followInfoHiveEntity != null) {
        followInfoHiveEntity.status = AmityFollowStatus.NONE.value;
        followInfoHiveEntity.save();
      }
    }

    return AmityFollowStatus.values
        .firstWhere((element) => element.value == follow.status, orElse: (() => AmityFollowStatus.NONE));
  }

  @override
  Future<AmityUserFollowInfo> getFollowInfo(String userId) async {
    final data = await followWApiInterface.getFollowInfo(userId);

    AmityFollowStatus status = AmityFollowStatus.NONE;

    //Save the follow information
    if (data.follows != null && data.follows!.isNotEmpty) {
      final followHiveEntity = data.follows![0].convertFollowHiveEntity();
      await followDbAdapter.saveFollowEntity(followHiveEntity);

      status = AmityFollowStatusExtension.enumOf(followHiveEntity.status!);
    }

    //Save the following info information
    final followInfoHiveEntity = data.convertToFollowInfoHiveEntity();
    followInfoHiveEntity.status = status.value;
    await followInfoDbAdapter.saveFollowInfo(followInfoHiveEntity);

    //Convert the hive entity to public model
    final amityUserFollowInfo = followInfoHiveEntity.convertToAmityUserFollowInfo();

    return amityUserFollowInfo;
  }

  @override
  Future updateFollowInfoStatus(String userId, AmityFollowStatus status) async {
    final followInfoHiveEntity = followInfoDbAdapter.getFollowInfo(userId);

    //Save the follow information
    if (followInfoHiveEntity != null) {
      followInfoHiveEntity.status = status.value;
      followInfoHiveEntity.save();
      return;
    }
  }

  @override
  Future<PageListData<List<AmityFollowRelationship>, String>> getFollower(FollowRequest request) async {
    final data = await followWApiInterface.getFollower(request);

    final followRelationships = await saveFollowResponse(data);

    return PageListData(followRelationships, data.paging!.next ?? '');
  }

  @override
  Future<PageListData<List<AmityFollowRelationship>, String>> getFollowing(FollowRequest request) async {
    final data = await followWApiInterface.getFollowing(request);

    final followRelationships = await saveFollowResponse(data);

    return PageListData(followRelationships, data.paging!.next ?? '');
  }

  @override
  Future<AmityMyFollowInfo> getMyFollowInfo() async {
    final data = await followWApiInterface.getMyFollowInfo();

    final followInfoHiveEntity = data.convertToFollowInfoHiveEntity();
    await followInfoDbAdapter.saveFollowInfo(followInfoHiveEntity);

    final amityUserFollowInfo = followInfoHiveEntity.convertToAmityMyFollowInfo();

    return amityUserFollowInfo;
  }

  @override
  Future<PageListData<List<AmityFollowRelationship>, String>> getMyFollower(FollowRequest request) async {
    final data = await followWApiInterface.getMyFollower(request);

    final followRelationships = await saveFollowResponse(data);

    return PageListData(followRelationships, data.paging!.next ?? '');
  }

  @override
  Future<PageListData<List<AmityFollowRelationship>, String>> getMyFollowing(FollowRequest request) async {
    final data = await followWApiInterface.getMyFollowing(request);

    final followRelationships = await saveFollowResponse(data);

    return PageListData(followRelationships, data.paging!.next ?? '');
  }

  Future<List<AmityFollowRelationship>> saveFollowResponse(FollowResponse data) async {
    //Covert to Follow Hive Entity
    List<FollowHiveEntity> followHiveEntitys = data.follows.map((e) => e.convertFollowHiveEntity()).toList();

    //Covert to User Hive Entity
    List<UserHiveEntity> userHiveEntitys = data.users!.map((e) => e.convertToUserHiveEntity()).toList();

    //Covert to File Hive Entity
    List<FileHiveEntity> fileHiveEntitys = data.files!.map((e) => e.convertToFileHiveEntity()).toList();

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
    return followHiveEntitys.map((e) => e.convertToAmityFollowRelationship()).toList();
  }
}
