import 'dart:ffi';

import 'package:amity_sdk/src/data/data_source/local/interface/permission_object.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'community_permission_hive_entity_13.g.dart';



@HiveType(typeId: 13)
class CommnityPermissionHiveEntity extends HiveObject
    implements PermissionObject {
  String? communityId;
  String? userId;
  String? permissionName;

  @override
  int get hashCode => Object.hash(communityId, userId, permissionName);

  @override
  CommnityPermissionHiveEntity create(
      String targetId, String userId, String permissionName) {
    final commnityPermissionHiveEntity = CommnityPermissionHiveEntity();
    commnityPermissionHiveEntity.communityId = targetId;
    commnityPermissionHiveEntity.userId = userId;
    commnityPermissionHiveEntity.permissionName = permissionName;
    return commnityPermissionHiveEntity;
  }
}
