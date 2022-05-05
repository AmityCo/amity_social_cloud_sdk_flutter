import 'package:amity_sdk/src/data/data_source/local/hive_entity/community_hive_entity_9.dart';

abstract class CommunityDbAdapter {
  Future saveCommunityEntity(CommunityHiveEntity entity);
  CommunityHiveEntity getCommunityEntity(String id);
}
