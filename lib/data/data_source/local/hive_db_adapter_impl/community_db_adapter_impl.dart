import 'package:amity_sdk/data/data_source/local/db_adapter/community_db_adapter.dart';
import 'package:amity_sdk/data/data_source/local/hive_entity/community_hive_entity_9.dart';
import 'package:amity_sdk/data/data.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CommunityDbAdapterImpl extends CommunityDbAdapter {
  final DBClient dbClient;

  CommunityDbAdapterImpl({required this.dbClient});
  late Box box;
  Future<CommunityDbAdapterImpl> init() async {
    Hive.registerAdapter(CommentHiveEntityAdapter());
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
