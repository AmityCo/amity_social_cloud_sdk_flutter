import 'package:amity_sdk/data/data_source/local/hive_entity/feed_hive_entity_10.dart';

abstract class FeedDbAdapter {
  Future updateFeedCollection(FeedHiveEntity entity);
  FeedHiveEntity? getFeedEntity(String id);
  Stream<FeedHiveEntity> listenFeedEntity(String id);
}
