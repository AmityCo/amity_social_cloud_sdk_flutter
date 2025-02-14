import 'dart:async';
import 'dart:math';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/utils/amity_nonce.dart';
import 'package:amity_sdk/src/core/utils/model_mapper.dart';
import 'package:amity_sdk/src/data/converter/user/users_response_extension.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:collection/collection.dart';

class UserRepoImpl extends UserRepo {
  final UserApiInterface userApiInterface;
  final FollowApiInterface followApiInterface;
  final UserDbAdapter userDbAdapter;
  final FileDbAdapter fileDbAdapter;
  final FollowDbAdapter followDbAdapter;
  final FollowInfoDbAdapter followInfoDbAdapter;
  final PagingIdDbAdapter pagingIdRepo;
  UserRepoImpl(
      {required this.userApiInterface,
      required this.followApiInterface,
      required this.userDbAdapter,
      required this.fileDbAdapter,
      required this.followDbAdapter,
      required this.followInfoDbAdapter,
      required this.pagingIdRepo});
  @override
  Future<AmityUser> getUserById(String userId) async {
    final data = await userApiInterface.getUserById(userId);

    final userHiveEntity = data.users[0].convertToUserHiveEntity();
    await userDbAdapter.saveUserEntity(userHiveEntity);

    final amityUser = userHiveEntity.convertToAmityUser();
    return amityUser;
  }

  @override
  Future<PageListData<List<AmityUser>, String>> getUsers(
      UsersRequest request) async {
    final data = await userApiInterface.getUsers(request);

    final userHiveEntities =
        data.users.map((e) => e.convertToUserHiveEntity()).toList();

    final fileHiveEntities =
        data.files.map((e) => e.convertToFileHiveEntity()).toList();

    for (var userEntity in userHiveEntities) {
      await userDbAdapter.saveUserEntity(userEntity);
    }
    for (var fileEntity in fileHiveEntities) {
      await fileDbAdapter.saveFileEntity(fileEntity);
    }

    final amityUsers = userHiveEntities
        .where((user) => !(user.isDeleted ?? false))
        .map((e) => e.convertToAmityUser())
        .toList();

    return PageListData(amityUsers, data.paging!.next ?? '');
  }

  @override
  Future<PageListData<List<AmityUser>, String>> queryUsers(
      UsersRequest request) async {
    final hash = request.getHashCode();
    final nonce = request.getNonce();
    int nextIndex = 0;
    final isFirstPage =
        request.options?.token == null && (request.options?.limit ?? 0) > 0;
    final data = await userApiInterface.getUsers(request);
    await data.saveToDb<AmityUser>(userDbAdapter, fileDbAdapter);
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
    final pagingIds = data.users
        .mapIndexed((index, element) => PagingIdHiveEntity(
              id: element.userId,
              hash: hash,
              nonce: nonce.value,
              position: nextIndex + index,
            ))
        .toList();
    await pagingIdRepo.savePagingIdEntities(pagingIds);
    return PageListData(<AmityUser>[], data.paging?.next ?? '');
  }

  @override
  Stream<List<AmityUser>> listenUserChanges(
      RequestBuilder<UsersRequest> request) {
    final users = userDbAdapter.listenUserEntities(request);
    // Only for notify the changes from the database
    return users.map((event) => <AmityUser>[]);
  }

  @override
  List<UserHiveEntity> getUserEntities(RequestBuilder<UsersRequest> request) {
    return userDbAdapter.getUserEntities(request);
  }

  @override
  Future<AmityUser> getUserByIdFromDb(String userId) async {
    final userHiveEntity = userDbAdapter.getUserEntity(userId);
    return userHiveEntity.convertToAmityUser();
  }

  @override
  List<String> getPermissions(String userId) {
    final userHiveEntity = userDbAdapter.getUserEntity(userId);
    return userHiveEntity.permissions ?? [];
  }

  @override
  Future<List<AmityUser>> updateUser(UpdateUserRequest request) async {
    final data = await userApiInterface.updateUser(request);

    final userHiveEntities =
        data.users.map((e) => e.convertToUserHiveEntity()).toList();

    final fileHiveEntities =
        data.files.map((e) => e.convertToFileHiveEntity()).toList();

    for (var fileEntity in fileHiveEntities) {
      await fileDbAdapter.saveFileEntity(fileEntity);
    }

    for (var userEntity in userHiveEntities) {
      await userDbAdapter.saveUserEntity(userEntity);
    }

    final amityUsers =
        userHiveEntities.map((e) => e.convertToAmityUser()).toList();
    return amityUsers;
  }

  @override
  Future<AmityUser> flag(String userId) async {
    final data = await userApiInterface.flag(userId);

    final userHiveEntities =
        data.users.map((e) => e.convertToUserHiveEntity()).toList();

    for (var userEntity in userHiveEntities) {
      await userDbAdapter.saveUserEntity(userEntity);
    }

    final amityUsers =
        userHiveEntities.map((e) => e.convertToAmityUser()).toList();
    return amityUsers.first;
  }

  @override
  Future<AmityUser> unflag(String userId) async {
    final data = await userApiInterface.unflag(userId);

    final userHiveEntities =
        data.users.map((e) => e.convertToUserHiveEntity()).toList();

    for (var userEntity in userHiveEntities) {
      await userDbAdapter.saveUserEntity(userEntity);
    }

    final amityUsers =
        userHiveEntities.map((e) => e.convertToAmityUser()).toList();
    return amityUsers.first;
  }

  @override
  Future block(String userId) async {
    final followInfo = await userApiInterface.block(userId);

    ///Update the follow info counts from the backend
    AmityFollowStatus status = AmityFollowStatus.NONE;
    //Save the follow information
    if (followInfo.follows != null && followInfo.follows!.isNotEmpty) {
      final followHiveEntity = followInfo.follows![0].convertFollowHiveEntity();
      await followDbAdapter.saveFollowEntity(followHiveEntity);
      status = AmityFollowStatusExtension.enumOf(followHiveEntity.status!);
    }
    final followInfoHiveEntity = followInfo.convertToFollowInfoHiveEntity();
    followInfoHiveEntity.status = status.value;
    await followInfoDbAdapter.saveFollowInfo(followInfoHiveEntity);

    return true;
  }

  @override
  Future unblock(String userId) async {
    final followInfo = await userApiInterface.unblock(userId);

    // ///Update the follow info counts from the backend
    AmityFollowStatus status = AmityFollowStatus.NONE;
    //Save the follow information
    if (followInfo.follows != null && followInfo.follows!.isNotEmpty) {
      final followHiveEntity = followInfo.follows![0].convertFollowHiveEntity();
      await followDbAdapter.saveFollowEntity(followHiveEntity);
      status = AmityFollowStatusExtension.enumOf(followHiveEntity.status!);
    }
    final followInfoHiveEntity = followInfo.convertToFollowInfoHiveEntity();
    followInfoHiveEntity.status = status.value;
    await followInfoDbAdapter.saveFollowInfo(followInfoHiveEntity);

    return true;
  }

  @override
  Future<PageListData<List<AmityUser>, String>> getBlockedUsers(
      OptionsRequest request) async {
    final data = await userApiInterface.getBlockedUsers(request);

    final userHiveEntities =
        data.users.map((e) => e.convertToUserHiveEntity()).toList();

    final fileHiveEntities =
        data.files.map((e) => e.convertToFileHiveEntity()).toList();

    for (var userEntity in userHiveEntities) {
      await userDbAdapter.saveUserEntity(userEntity);
    }
    for (var fileEntity in fileHiveEntities) {
      await fileDbAdapter.saveFileEntity(fileEntity);
    }

    final amityUsers =
        userHiveEntities.map((e) => e.convertToAmityUser()).toList();

    return PageListData(amityUsers, data.paging!.next ?? '');
  }

  @override
  List<AmityUser> getUsersFromDB() {
    final userHiveEntities = userDbAdapter.getUsers();
    return userHiveEntities.map((e) => e.convertToAmityUser()).toList();
  }

  @override
  bool hasLocalUser(String userId) {
    final userHiveEntity = userDbAdapter.getUserEntityIfPresent(userId);
    return userHiveEntity != null;
  }

  @override
  Future<AmityUser?> fetchAndSave(String objectId) async {
    var user = await getUserById(objectId);
    if (user != null) {
      return user;
    } else {
      return Future.value(null);
    }
  }

  @override
  ModelMapper<UserHiveEntity, AmityUser> mapper() {
    return UserModelMapper();
  }

  @override
  StreamController<UserHiveEntity> observeFromCache(String objectId) {
    final streamController = StreamController<UserHiveEntity>();
    userDbAdapter.listenEntity(objectId).listen((event) {
      streamController.add(event);
    });
    return streamController;
  }

  @override
  Future<UserHiveEntity?> queryFromCache(String objectId) async {
    return userDbAdapter.getUserEntity(objectId);
  }

  @override
  Stream<List<UserHiveEntity>> listenUserEntities() {
    return userDbAdapter.listenUserEntities(() => UsersRequest());
  }
}

class UserModelMapper extends ModelMapper<UserHiveEntity, AmityUser> {
  @override
  AmityUser map(UserHiveEntity entity) {
    return entity.convertToAmityUser();
  }
}
