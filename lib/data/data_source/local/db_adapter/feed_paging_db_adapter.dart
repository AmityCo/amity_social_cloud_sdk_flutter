import 'package:amity_sdk/data/data_source/local/hive_entity/feed_paging_hive_entity_10.dart';

abstract class FeedPagingDbAdapter {
  Future updateFeedCollection(FeedPagingHiveEntity entity);
  FeedPagingHiveEntity? getFeedEntity(String id);
  Stream<FeedPagingHiveEntity> listenFeedEntity(String id);
}
