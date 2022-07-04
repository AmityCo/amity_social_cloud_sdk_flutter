import 'package:amity_sdk/src/data/data_source/local/hive_entity/follow_info_hive_entity_2.dart';

abstract class FollowInfoDbAdapter {
  Future saveFollowInfo(FollowInfoHiveEntity entity);
  FollowInfoHiveEntity? getFollowInfo(String id);

  Stream<FollowInfoHiveEntity> stream(String id);
}
