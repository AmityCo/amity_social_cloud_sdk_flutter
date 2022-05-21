import 'package:amity_sdk/src/data/data_source/local/hive_entity/community_member_paging_hive_entity_15.dart';

abstract class CommunityMemberPagingDbAdapter {
  Future updateCommunityMemmberCollection(
      CommunityMemberPagingHiveEntity entity);
  CommunityMemberPagingHiveEntity? getCommunityMemmberPagingEntity(String id);
  Stream<CommunityMemberPagingHiveEntity> listenCommunityMemmberPagingEntity(
      String id);
}
