import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class UserRepoImpl extends UserRepo {
  final UserApiInterface userApiInterface;
  final UserDbAdapter userDbAdapter;
  final FileDbAdapter fileDbAdapter;
  UserRepoImpl(
      {required this.userApiInterface,
      required this.userDbAdapter,
      required this.fileDbAdapter});
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

    final amityUsers =
        userHiveEntities.map((e) => e.convertToAmityUser()).toList();

    return PageListData(amityUsers, data.paging!.next ?? '');
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
}
