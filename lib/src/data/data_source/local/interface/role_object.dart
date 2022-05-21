import 'package:hive_flutter/hive_flutter.dart';

abstract class RoleObject<HIVE_ENTITY extends HiveObject> {
  HIVE_ENTITY create(String targetId, String userId, String roleName);
}
