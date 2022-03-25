import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/data/data_source/local/db_adapter/feed_paging_db_adapter.dart';
import 'package:amity_sdk/data/data_source/local/hive_entity/feed_paging_hive_entity_10.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FeedPagingDbAdapterImpl extends FeedPagingDbAdapter {
  final DBClient dbClient;

  FeedPagingDbAdapterImpl({required this.dbClient});
  late Box box;
  Future<FeedPagingDbAdapterImpl> init() async {
    Hive.registerAdapter(FeedPagingHiveEntityAdapter());
    box = await Hive.openBox<FeedPagingHiveEntity>('feed_db');
    return this;
  }

  @override
  FeedPagingHiveEntity? getFeedEntity(String id) {
    return box.get(id);
  }

  @override
  Future updateFeedCollection(FeedPagingHiveEntity entity) async {
    FeedPagingHiveEntity? feedHiveEntity = await box.get(entity.id);
    if (feedHiveEntity == null) {
      await box.put(entity.id, entity);
      return;
    }

    //Update exsisting object
    feedHiveEntity.postIds?.addAll(entity.postIds!);
    feedHiveEntity.nextToken = entity.nextToken;
    feedHiveEntity.prevToken = entity.prevToken;
    await box.put(entity.id, feedHiveEntity);
  }

  @override
  Stream<FeedPagingHiveEntity> listenFeedEntity(String id) {
    return box.watch(key: id).map((event) => event.value);
  }
}
