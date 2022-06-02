// ignore_for_file: hash_and_equals

import 'package:amity_sdk/src/data/data_source/local/interface/role_object.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'community_role_hive_entity_12.g.dart';

@HiveType(typeId: 12)
class CommunityRoleHiveEntity extends HiveObject implements RoleObject {
  String? communityId;
  String? userId;
  String? roleName;

  @override
  int get hashCode => Object.hash(communityId, userId, roleName);

  @override
  CommunityRoleHiveEntity create(
      String targetId, String userId, String roleName) {
    final communityRoleHiveEntity = CommunityRoleHiveEntity();
    communityRoleHiveEntity.communityId = targetId;
    communityRoleHiveEntity.userId = userId;
    communityRoleHiveEntity.roleName = roleName;
    return communityRoleHiveEntity;
  }
}
