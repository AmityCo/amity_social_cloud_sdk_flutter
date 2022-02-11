import 'package:amity_sdk/core/model/api_request/users_request.dart';
import 'package:amity_sdk/public/public.dart';

abstract class UserRepo {
  Future<AmityUser> getUserById(String userId);

  Future<List<AmityUser>> getUsers(UsersRequest request);
}
