import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/enum/amity_error.dart';
import 'package:amity_sdk/src/data/data_source/data_source.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/tombstone_db_adapter.dart';

abstract class TombstoneRepository{

  TombstoneHiveEntity? getTombstone(String objectId, TombstoneModelType tombstoneModelType);

  void saveTombstone({required String objectId ,
        required TombstoneModelType tombstoneModelType, required AmityError error});


}