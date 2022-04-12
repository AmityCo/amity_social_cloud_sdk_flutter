import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';

abstract class UserRepo {
  Future<AmityUser> getUserById(String userId);
  Future<AmityUser> getUserByIdFromDb(String userId);

  Future<List<AmityUser>> getUsers(UsersRequest request);
}
