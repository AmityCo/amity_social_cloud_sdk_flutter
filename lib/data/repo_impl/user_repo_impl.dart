import 'package:amity_sdk/core/model/api_request/users_request.dart';
import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/domain/model/amity_user.dart';
import 'package:amity_sdk/domain/repo/user_repo.dart';

class UserRepoImpl extends UserRepo {
  final UserApiInterface userApiInterface;

  UserRepoImpl({required this.userApiInterface});
  @override
  Future<AmityUser> getUserById(String userId) async {
    final data = await userApiInterface.getUserById(userId);
    final userHiveEntity = data.users[0].convertToUserHiveEntity();
    final amityUser = userHiveEntity.convertToAmityUser();
    return amityUser;
  }

  @override
  Future<List<AmityUser>> getUsers(UsersRequest request) async {
    final data = await userApiInterface.getUsers(request);
    final userHiveEntities =
        data.users.map((e) => e.convertToUserHiveEntity()).toList();
    final amityUsers =
        userHiveEntities.map((e) => e.convertToAmityUser()).toList();
    return amityUsers;
  }
}
