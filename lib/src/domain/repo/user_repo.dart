import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

abstract class UserRepo {
  Future<AmityUser> getUserById(String userId);
  Future<AmityUser> getUserByIdFromDb(String userId);
  Future<PageListData<List<AmityUser>, String>> getUsers(UsersRequest request);
  List<String> getPermissions(String userId);
  Future<List<AmityUser>> updateUser(UpdateUserRequest request);
  Future<AmityUser> flag(String userId);
  Future<AmityUser> unflag(String userId);
  Future block(String userId);
  Future unblock(String userId);
  Future<PageListData<List<AmityUser>, String>> getBlockedUsers(OptionsRequest request);
}
