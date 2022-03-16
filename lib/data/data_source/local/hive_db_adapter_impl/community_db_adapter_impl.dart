import 'package:amity_sdk/data/data.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CommunityDbAdapterImpl extends CommunityDbAdapter {
  final DBClient dbClient;

  CommunityDbAdapterImpl({required this.dbClient});
  late Box box;
  Future<CommunityDbAdapterImpl> init() async {
    Hive.registerAdapter(CommunityHiveEntityAdapter());
    box = await Hive.openBox<CommunityHiveEntity>('community_db');
    return this;
  }

  @override
  CommunityHiveEntity getCommunityEntity(String id) {
    throw UnimplementedError();
  }

  @override
  Future saveCommunityEntity(CommunityHiveEntity entity) {
    throw UnimplementedError();
  }
}
