// ignore_for_file: hash_and_equals

import 'package:amity_sdk/src/data/data_source/local/interface/permission_object.dart';
import 'package:hive/hive.dart';

part 'community_permission_hive_entity_13.g.dart';

@HiveType(typeId: 25)
class CommnityPermissionHiveEntity extends HiveObject
    implements PermissionObject {
  String? id;
  String? communityId;
  String? userId;
  String? permissionName;

  @override
  int get hashCode => Object.hash(communityId, userId, permissionName);

  @override
  CommnityPermissionHiveEntity create(
      String targetId, String userId, String permissionName) {
    final commnityPermissionHiveEntity = CommnityPermissionHiveEntity();
    commnityPermissionHiveEntity.id = targetId + userId;
    commnityPermissionHiveEntity.communityId = targetId;
    commnityPermissionHiveEntity.userId = userId;
    commnityPermissionHiveEntity.permissionName = permissionName;
    return commnityPermissionHiveEntity;
  }
}
