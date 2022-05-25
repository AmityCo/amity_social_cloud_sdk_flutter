import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/community_category_db_adater.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/community_category_hive_12.dart';
import 'package:hive/hive.dart';

class CommunityCategoryDbAdapterImpl extends CommunityCategoryDbAdapter {
  final DBClient dbClient;

  CommunityCategoryDbAdapterImpl({required this.dbClient});
  late Box box;
  Future<CommunityCategoryDbAdapterImpl> init() async {
    Hive.registerAdapter(CommunityCategoryHiveEntityAdapter(), override: true);
    box = await Hive.openBox<CommunityCategoryHiveEntity>(
        'community_category_db');
    return this;
  }

  @override
  CommunityCategoryHiveEntity getCommunityCategoryEntity(String id) {
    return box.get(id);
  }

  @override
  Future saveCommunityCategoryEntity(CommunityCategoryHiveEntity entity) async {
    await box.put(entity.categoryId, entity);
  }
}
