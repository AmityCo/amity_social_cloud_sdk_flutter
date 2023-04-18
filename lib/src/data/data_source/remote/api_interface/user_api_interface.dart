import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';

abstract class UserApiInterface {
  Future<UsersResponse> getUserById(String userId);
  Future<UsersResponse> getUsers(UsersRequest request);
  Future<UsersResponse> updateUser(UpdateUserRequest request);
  Future<UsersResponse> flag(String userId);
  Future<UsersResponse> unflag(String userId);
  Future<FollowInfoResponse> block(String userId);
  Future<FollowInfoResponse> unblock(String userId);
  Future<UsersResponse> getBlockedUsers(OptionsRequest request);
}
