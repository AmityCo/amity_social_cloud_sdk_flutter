import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/utils/amity_hive_type.dart';
import 'package:hive/hive.dart';

part 'community_member_hive_entity_14.g.dart';

@HiveType(typeId: AmityHiveType.communityMember)
class CommunityMemberHiveEntity extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? communityId;

  @HiveField(2)
  String? channelId;

  @HiveField(3)
  String? userId;

  @HiveField(4)
  String? communityMembership;

  @HiveField(5)
  List<String>? roles;

  @HiveField(6)
  List<String>? permissions;

  @HiveField(7)
  bool? isBanned;

  @HiveField(8)
  bool? isDeleted;

  CommunityMemberHiveEntity({
    this.id,
    this.communityId,
    this.channelId,
    this.userId,
    this.communityMembership,
    this.roles,
    this.permissions,
    this.isBanned,
    this.isDeleted,
  });

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
    return 'CommunityMemberHiveEntity(id: $id, communityId: $communityId, channelId: $channelId, userId: $userId, communityMembership: $communityMembership, roles: $roles, permissions: $permissions, isBanned: $isBanned, isDeleted: $isDeleted)';
  }
}
