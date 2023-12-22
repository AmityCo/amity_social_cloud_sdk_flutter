import 'package:amity_sdk/src/data/data_source/local/db_adapter/tombstone_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/tombstone_hive_entity_22.dart';
import 'package:amity_sdk/src/src.dart';
import 'package:hive/hive.dart';

class TombstoneDbAdapterImpl extends TombstoneDbAdapter{
  final DBClient dbClient;
  late Box box;

  
  TombstoneDbAdapterImpl({required this.dbClient});

  Future<TombstoneDbAdapterImpl> init() async {
    Hive.registerAdapter(TombstoneHiveEntityAdapter(), override: true);
    box = await Hive.openBox<TombstoneHiveEntity>('tombstone_db');
    return this;
  }
  


  @override
  Future saveTombstone(TombstoneHiveEntity tombstoneEntity) async {
    await box.add(tombstoneEntity);
  }
  
  @override
  TombstoneHiveEntity? getTombstone(String objectId, TombstoneModelType tombstoneModelType) {
    var list = box.values.where((element) => element["objectId"]==objectId).toList();

    if(list.isEmpty){
      return null;
    }

    return  list.first ?? null;
  }
  
  @override
  Future insert(List<EkoObject> objects) async {
    await box.add(objects);
  }

}