import 'package:amity_sdk/src/core/model/api_request/users_request.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/model/amity_user.dart';
import 'package:amity_sdk/src/domain/repo/user_repo.dart';

class UserRepoImpl extends UserRepo {
  final UserApiInterface userApiInterface;
  final UserDbAdapter userDbAdapter;
  UserRepoImpl({required this.userApiInterface, required this.userDbAdapter});
  @override
  Future<AmityUser> getUserById(String userId) async {
    final data = await userApiInterface.getUserById(userId);

    //TODO compare updated at local vs remote
    final userHiveEntity = data.users[0].convertToUserHiveEntity();
    await userDbAdapter.saveUserEntity(userHiveEntity);

    final amityUser = userHiveEntity.convertToAmityUser();
    return amityUser;
  }

  @override
  Future<List<AmityUser>> getUsers(UsersRequest request) async {
    final data = await userApiInterface.getUsers(request);

    final userHiveEntities =
        data.users.map((e) => e.convertToUserHiveEntity()).toList();

    for (var userEntity in userHiveEntities) {
      await userDbAdapter.saveUserEntity(userEntity);
    }

    final amityUsers =
        userHiveEntities.map((e) => e.convertToAmityUser()).toList();
    return amityUsers;
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
}
