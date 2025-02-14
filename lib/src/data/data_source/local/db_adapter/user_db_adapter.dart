import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data_source/data_source.dart';

abstract class UserDbAdapter {
  Future saveUserEntity(UserHiveEntity entity);
  Future saveUserEntities(List<UserHiveEntity> entities);
  UserHiveEntity getUserEntity(String userId);
  Stream<UserHiveEntity> listenEntity(String userId);
  List<UserHiveEntity> getUsers();
  Stream<List<UserHiveEntity>> listenUserEntities(
      RequestBuilder<UsersRequest> request);
  List<UserHiveEntity> getUserEntities(RequestBuilder<UsersRequest> request);

  UserHiveEntity? getUserEntityIfPresent(String userId);
}
