import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/follow_hive_entity_3.dart';

abstract class FollowDbAdapter {
  Future saveFollowEntity(FollowHiveEntity entity);
  FollowHiveEntity? getFollowEntiry(String id);

  Stream<FollowHiveEntity> stream(String id);

  Stream<List<FollowHiveEntity>> listenFollowEntities(
      RequestBuilder<FollowRequest> request);

  List<FollowHiveEntity> getFollowEntities(
      RequestBuilder<FollowRequest> request);
}
