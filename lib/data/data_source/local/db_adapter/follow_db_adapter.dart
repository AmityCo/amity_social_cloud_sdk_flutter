import 'package:amity_sdk/data/data_source/local/hive_entity/follow_hive_entity_3.dart';

abstract class FollowDbAdapter {
  Future saveFollowEntity(FollowHiveEntity entity);
  FollowHiveEntity getFollowEntiry(String userId);
}
