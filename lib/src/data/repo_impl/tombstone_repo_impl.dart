import 'package:amity_sdk/src/core/enum/amity_error.dart';
import 'package:amity_sdk/src/core/enum/tombstone_type.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/tombstone_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/tombstone_hive_entity_22.dart';
import 'package:amity_sdk/src/domain/repo/tombstone_repo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class TombstoneRepoImpl extends TombstoneRepository {
  
  final TombstoneDbAdapter tombstoneDbAdapter;

  TombstoneRepoImpl({required this.tombstoneDbAdapter});

  @override
  TombstoneHiveEntity? getTombstone(
      String objectId, TombstoneModelType tombstoneModelType) {
    return tombstoneDbAdapter.getTombstone(objectId, tombstoneModelType);
  }

  @override
  void saveTombstone(
      {required String objectId, required TombstoneModelType tombstoneModelType   , required AmityError error})  {
    TombstoneHiveEntity tombstoneEntity = TombstoneHiveEntity();
    tombstoneEntity.objectId = objectId;
    tombstoneEntity.setCreatedAt(DateTime.now());
    tombstoneEntity.modelType = tombstoneModelType.value;
    tombstoneEntity.errorCode = error.code;
    tombstoneDbAdapter.save([tombstoneEntity]);
  }
}
