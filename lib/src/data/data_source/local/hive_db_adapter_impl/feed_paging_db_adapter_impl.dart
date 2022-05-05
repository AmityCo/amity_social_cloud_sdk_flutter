import 'package:amity_sdk/src/data/data.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FeedPagingDbAdapterImpl extends FeedPagingDbAdapter {
  final DBClient dbClient;

  FeedPagingDbAdapterImpl({required this.dbClient});
  late Box box;
  Future<FeedPagingDbAdapterImpl> init() async {
    Hive.registerAdapter(FeedPagingHiveEntityAdapter(), override: true);
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
