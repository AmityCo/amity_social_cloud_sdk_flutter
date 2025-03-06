// ignore_for_file: unused_local_variable

import 'dart:math';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/utils/amity_nonce.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/repo/paging_id_repo.dart';
import 'package:collection/collection.dart';

class FollowRepoImpl extends FollowRepo {
  final FollowApiInterface followWApiInterface;
  final FollowInfoDbAdapter followInfoDbAdapter;
  final FollowDbAdapter followDbAdapter;
  final UserDbAdapter userDbAdapter;
  final FileDbAdapter fileDbAdapter;
  final PagingIdRepo pagingIdRepo;

  FollowRepoImpl({
    required this.followWApiInterface,
    required this.followInfoDbAdapter,
    required this.followDbAdapter,
    required this.userDbAdapter,
    required this.fileDbAdapter,
    required this.pagingIdRepo,
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
      followInfoHiveEntity.followerCount =
          (followInfoHiveEntity.followerCount ?? 0) + 1;
      followInfoHiveEntity.status = AmityFollowStatus.ACCEPTED.value;
      await followInfoHiveEntity.save();
    }

    return AmityFollowStatus.values.firstWhere(
        (element) => element.value == follow.status,
        orElse: (() => AmityFollowStatus.NONE));
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
      followInfoHiveEntity.followerCount =
          (followInfoHiveEntity.followerCount ?? 0) - 1;
      followInfoHiveEntity.status = AmityFollowStatus.NONE.value;
      await followInfoHiveEntity.save();
    }

    return AmityFollowStatus.values.firstWhere(
        (element) => element.value == follow.status,
        orElse: (() => AmityFollowStatus.NONE));
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
        followInfoHiveEntity.followerCount =
            (followInfoHiveEntity.followerCount ?? 0) + 1;
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

    return AmityFollowStatus.values.firstWhere(
        (element) => element.value == follow.status,
        orElse: (() => AmityFollowStatus.NONE));
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
        followInfoHiveEntity.followerCount =
            (followInfoHiveEntity.followerCount ?? 0) - 1;
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

    return AmityFollowStatus.values.firstWhere(
        (element) => element.value == follow.status,
        orElse: (() => AmityFollowStatus.NONE));
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
    final amityUserFollowInfo =
        followInfoHiveEntity.convertToAmityUserFollowInfo();

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
  Future<PageListData<List<AmityFollowRelationship>, String>> getFollower(
      FollowRequest request) async {
    // final data = await followWApiInterface.getFollower(request);

    // final followRelationships = await saveFollowResponse(data);

    // return PageListData(followRelationships, data.paging!.next ?? '');
    final hash = request.getHashCode();
    final nonce = request.getFollowerNonce();
    int nextIndex = 0;
    final data = await followWApiInterface.getFollower(request);
    final paging = data.paging;
    final followRelationships = await saveFollowResponse(data);
    final isFirstPage =
        request.options?.token == null && (request.options?.limit ?? 0) > 0;
    if (isFirstPage) {
      await pagingIdRepo.deletePagingIdByHash(nonce.value, hash);
    } else {
      nextIndex = (pagingIdRepo
              .getPagingIdEntities(nonce.value, hash)
              .map((e) => (e.position ?? 0))
              .toList()
              .reduce(max)) +
          1;
    }
    data.follows.forEachIndexed((index, element) async {
      final pagingId = PagingIdHiveEntity(
        id: "${element.from}_${element.to}",
        hash: hash,
        nonce: nonce.value,
        position: nextIndex + index,
      );
      await pagingIdRepo.savePagingId(pagingId);
    });
    return PageListData(followRelationships, paging?.next ?? '');
  }

  @override
  Future<PageListData<List<AmityFollowRelationship>, String>> getFollowing(
      FollowRequest request) async {
    // final data = await followWApiInterface.getFollowing(request);
    // final followRelationships = await saveFollowResponse(data);

    final hash = request.getHashCode();
    final nonce = request.getFollowingNonce();
    int nextIndex = 0;
    final data = await followWApiInterface.getFollowing(request);
    final paging = data.paging;
    final followRelationships = await saveFollowResponse(data);
    final isFirstPage =
        request.options?.token == null && (request.options?.limit ?? 0) > 0;
    if (isFirstPage) {
      await pagingIdRepo.deletePagingIdByHash(nonce.value, hash);
    } else {
      nextIndex = (pagingIdRepo
              .getPagingIdEntities(nonce.value, hash)
              .map((e) => (e.position ?? 0))
              .toList()
              .reduce(max)) +
          1;
    }
    data.follows.forEachIndexed((index, element) async {
      final pagingId = PagingIdHiveEntity(
        id: "${element.from}_${element.to}",
        hash: hash,
        nonce: nonce.value,
        position: nextIndex + index,
      );
      await pagingIdRepo.savePagingId(pagingId);
    });
    return PageListData(followRelationships, paging?.next ?? '');
  }

  @override
  Future<AmityMyFollowInfo> getMyFollowInfo() async {
    final data = await followWApiInterface.getMyFollowInfo();

    final followInfoHiveEntity = data.convertToFollowInfoHiveEntity();
    await followInfoDbAdapter.saveFollowInfo(followInfoHiveEntity);

    final amityUserFollowInfo =
        followInfoHiveEntity.convertToAmityMyFollowInfo();

    return amityUserFollowInfo;
  }

  @override
  Future<PageListData<List<AmityFollowRelationship>, String>> getMyFollower(
      FollowRequest request, bool isLegacy) async {
    final hash = request.getHashCode();
    final nonce = request.getFollowerNonce();
    int nextIndex = 0;
    final data = await followWApiInterface.getMyFollower(request);
    final paging = data.paging;
    final followRelationships = await saveFollowResponse(data);
    if (!isLegacy) {
      final isFirstPage =
          request.options?.token == null && (request.options?.limit ?? 0) > 0;
      if (isFirstPage) {
        await pagingIdRepo.deletePagingIdByHash(nonce.value, hash);
      } else {
        nextIndex = (pagingIdRepo
                .getPagingIdEntities(nonce.value, hash)
                .map((e) => (e.position ?? 0))
                .toList()
                .reduce(max)) +
            1;
      }
      data.follows.forEachIndexed((index, element) async {
        final pagingId = PagingIdHiveEntity(
          id: "${element.from}_${element.to}",
          hash: hash,
          nonce: nonce.value,
          position: nextIndex + index,
        );
        await pagingIdRepo.savePagingId(pagingId);
      });
    }
    return PageListData(followRelationships, paging?.next ?? '');
  }

  @override
  Future<PageListData<List<AmityFollowRelationship>, String>> getMyFollowing(
      FollowRequest request, bool isLegacy) async {
    final hash = request.getHashCode();
    final nonce = request.getFollowingNonce();
    int nextIndex = 0;
    final data = await followWApiInterface.getMyFollowing(request);
    final paging = data.paging;
    final followRelationships = await saveFollowResponse(data);
    if (!isLegacy) {
      final isFirstPage =
          request.options?.token == null && (request.options?.limit ?? 0) > 0;
      if (isFirstPage) {
        await pagingIdRepo.deletePagingIdByHash(nonce.value, hash);
      } else {
        nextIndex = (pagingIdRepo
                .getPagingIdEntities(nonce.value, hash)
                .map((e) => (e.position ?? 0))
                .toList()
                .reduce(max)) +
            1;
      }
      data.follows.forEachIndexed((index, element) async {
        final pagingId = PagingIdHiveEntity(
          id: "${element.from}_${element.to}",
          hash: hash,
          nonce: nonce.value,
          position: nextIndex + index,
        );
        await pagingIdRepo.savePagingId(pagingId);
      });
    }
    return PageListData(followRelationships, paging?.next ?? '');
  }

  Future<List<AmityFollowRelationship>> saveFollowResponse(
      FollowResponse data) async {
    //Covert to Follow Hive Entity
    List<FollowHiveEntity> followHiveEntitys =
        data.follows.map((e) => e.convertFollowHiveEntity()).toList();

    //Covert to User Hive Entity
    List<UserHiveEntity> userHiveEntitys =
        data.users!.map((e) => e.convertToUserHiveEntity()).toList();

    //Covert to File Hive Entity
    List<FileHiveEntity> fileHiveEntitys =
        data.files!.map((e) => e.convertToFileHiveEntity()).toList();

    //Save File Hive Entity
    for (var e in fileHiveEntitys) {
      await fileDbAdapter.saveFileEntity(e);
    }

    //Save User Hive Entity
    for (var e in userHiveEntitys) {
      await userDbAdapter.saveUserEntity(e);
    }

    //Save Follow Hive Entity
    for (var e in followHiveEntitys) {
      await followDbAdapter.saveFollowEntity(e);
    }

    return followHiveEntitys
        .map((e) => e.convertToAmityFollowRelationship())
        .toList();
  }

  @override
  Stream<List<AmityFollowRelationship>> listenFollowings(
      RequestBuilder<FollowRequest> request) {
    final req = request.call();
    return followDbAdapter.listenFollowEntities(request).map((event) {
      final List<AmityFollowRelationship> list = [];
      for (var element in event) {
        list.add(element.convertToAmityFollowRelationship());
      }
      return list;
    });
  }

  @override
  Stream<List<AmityFollowRelationship>> listenFollowers(
      RequestBuilder<FollowRequest> request) {
    final req = request.call();
    return followDbAdapter.listenFollowEntities(request).map((event) {
      final List<AmityFollowRelationship> list = [];
      for (var element in event) {
        list.add(element.convertToAmityFollowRelationship());
      }
      return list;
    });
  }

  @override
  List<FollowHiveEntity> getFollowEntities(
      RequestBuilder<FollowRequest> request) {
    return followDbAdapter.getFollowEntities(request);
  }
}
