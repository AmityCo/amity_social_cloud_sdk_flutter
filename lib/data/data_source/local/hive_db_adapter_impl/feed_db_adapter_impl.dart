import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/data/data_source/local/db_adapter/feed_db_adapter.dart';
import 'package:amity_sdk/data/data_source/local/hive_entity/feed_hive_entity_10.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FeedDbAdapterImpl extends FeedDbAdapter {
  final DBClient dbClient;

  FeedDbAdapterImpl({required this.dbClient});
  late Box box;
  Future<FeedDbAdapterImpl> init() async {
    Hive.registerAdapter(FeedHiveEntityAdapter());
    box = await Hive.openBox<FeedHiveEntity>('feed_db');
    return this;
  }

  @override
  FeedHiveEntity? getFeedEntity(String id) {
    return box.get(id);
  }

  @override
  Future updateFeedCollection(FeedHiveEntity entity) async {
    FeedHiveEntity? feedHiveEntity = await box.get(entity.id);
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
  Stream<FeedHiveEntity> listenFeedEntity(String id) {
    return box.watch(key: id).map((event) => event.value);
  }
}
