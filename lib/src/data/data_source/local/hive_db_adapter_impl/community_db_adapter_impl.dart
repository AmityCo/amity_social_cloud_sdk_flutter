import 'package:amity_sdk/src/data/data.dart';
import 'package:hive/hive.dart';

class CommunityDbAdapterImpl extends CommunityDbAdapter {
  final DBClient dbClient;

  CommunityDbAdapterImpl({required this.dbClient});
  late Box box;
  Future<CommunityDbAdapterImpl> init() async {
    Hive.registerAdapter(CommunityHiveEntityAdapter(), override: true);
    box = await Hive.openBox<CommunityHiveEntity>('community_db');
    return this;
  }

  @override
  CommunityHiveEntity getCommunityEntity(String id) {
    return box.get(id);
  }

  @override
  Future saveCommunityEntity(CommunityHiveEntity entity) async {
    await box.put(entity.communityId, entity);
  }

  @override
  Stream<CommunityHiveEntity> listenCommunityEntity(String communityId) {
    return box.watch(key: communityId).map((event) => event.value);
  }
}
