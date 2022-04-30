import 'package:amity_sdk/src/data/data_source/data_source.dart';

abstract class UserDbAdapter {
  Future saveUserEntity(UserHiveEntity entity);
  UserHiveEntity getUserEntity(String userId);
}
