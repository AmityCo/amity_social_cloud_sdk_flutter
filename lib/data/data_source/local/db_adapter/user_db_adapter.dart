import 'package:amity_sdk/data/data_source/data_source.dart';

abstract class UserDbAdapter {
  Future saveUser(UserHiveEntity entity);
  UserHiveEntity getUser(String userId);
}
