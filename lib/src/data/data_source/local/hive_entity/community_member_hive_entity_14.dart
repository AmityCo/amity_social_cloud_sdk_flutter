import 'package:hive_flutter/hive_flutter.dart';

part 'community_member_hive_entity_14.g.dart';

@HiveType(typeId: 14)
class CommnityMemberHiveEntity extends HiveObject {
  String? id;
  String? communityId;
  String? channelId;
  String? userId;
  String? communityMembership;
  List<String>? roles;
  List<String>? permissions;
  bool? isBanned;

  // Map<> metaData;

  @override
  int get hashCode => Object.hash(id, communityId, channelId, userId,
      communityMembership, roles, permissions, isBanned);

  @override
  bool operator ==(Object other) {
    return super.hashCode == other.hashCode;
  }

  @override
  String toString() {
    return 'CommnityMemberHiveEntity(id: $id, communityId: $communityId, channelId: $channelId, userId: $userId, communityMembership: $communityMembership, roles: $roles, permissions: $permissions, isBanned: $isBanned)';
  }
}
