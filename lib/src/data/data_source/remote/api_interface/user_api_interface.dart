import 'package:amity_sdk/src/core/model/api_request/update_user_request.dart';
import 'package:amity_sdk/src/core/model/api_request/users_request.dart';
import 'package:amity_sdk/src/data/response/users_response.dart';

abstract class UserApiInterface {
  Future<UsersResponse> getUserById(String userId);
  Future<UsersResponse> getUsers(UsersRequest request);
  Future<UsersResponse> updateUser(UpdateUserRequest request);
  Future<UsersResponse> flag(String userId);
  Future<UsersResponse> unflag(String userId);
}
