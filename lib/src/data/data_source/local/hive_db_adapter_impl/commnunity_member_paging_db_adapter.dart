import 'package:amity_sdk/src/data/data_source/data_source.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CommunityMemberPagingDbAdapterImpl
    extends CommunityMemberPagingDbAdapter {
  final DBClient dbClient;

  CommunityMemberPagingDbAdapterImpl({required this.dbClient});
  late Box box;

  Future<CommunityMemberPagingDbAdapterImpl> init() async {
    Hive.registerAdapter(CommunityMemberPagingHiveEntityAdapter(),
        override: true);
    box = await Hive.openBox<CommunityMemberPagingHiveEntity>(
        'community_member_paging_db');
    return this;
  }

  @override
  CommunityMemberPagingHiveEntity? getCommunityMemmberPagingEntity(String id) {
    return box.get(id);
  }

  @override
  Stream<CommunityMemberPagingHiveEntity> listenCommunityMemmberPagingEntity(
      String id) {
    return box.watch(key: id).map((event) => event.value);
  }

  @override
  Future updateCommunityMemmberCollection(
      CommunityMemberPagingHiveEntity entity) async {
    FeedPagingHiveEntity? feedHiveEntity = await box.get(entity.id);
    if (feedHiveEntity == null) {
      await box.put(entity.id, entity);
      return;
    }

    //Update exsisting object
    feedHiveEntity.postIds?.addAll(entity.communityMemberIds!);
    feedHiveEntity.nextToken = entity.nextToken;
    feedHiveEntity.prevToken = entity.prevToken;
    await box.put(entity.id, feedHiveEntity);
  }
}
