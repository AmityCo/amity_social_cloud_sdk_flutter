import 'package:amity_sdk/src/core/enum/amity_membership_sorting_order.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/community_member_hive_entity_14.dart';

abstract class CommunityMemberDbAdapter {
  Future saveCommunityMemberEntity(CommnityMemberHiveEntity entity);
  CommnityMemberHiveEntity getCommunityMemberEntity(String id);
  Future deleteCommunityMemberEntity(CommnityMemberHiveEntity entity);
  CommnityMemberHiveEntity getCommunityMemberEntities(
      String communityId,
      List<String> roles,
      List<String> memberships,
      AmityMembershipSortOption sortOption);
  Stream<CommnityMemberHiveEntity> listenCommnunityMemberEntity(String id);
}
