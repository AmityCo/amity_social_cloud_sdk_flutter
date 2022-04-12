import 'package:amity_sdk/core/model/api_request/users_request.dart';
import 'package:amity_sdk/data/response/users_response.dart';

abstract class UserApiInterface{

  Future<UsersResponse> getUserById(String userId);
  Future<UsersResponse> getUsers(UsersRequest request);
}