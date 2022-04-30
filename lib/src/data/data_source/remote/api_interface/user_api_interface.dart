import 'package:amity_sdk/src/core/model/api_request/users_request.dart';
import 'package:amity_sdk/src/data/response/users_response.dart';

abstract class UserApiInterface {
  Future<UsersResponse> getUserById(String userId);
  Future<UsersResponse> getUsers(UsersRequest request);
}
