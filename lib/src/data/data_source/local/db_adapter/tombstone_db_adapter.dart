import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data_source/data_source.dart';
import 'package:amity_sdk/src/data/data_source/local/base_adapter.dart';

abstract class TombstoneDbAdapter extends BaseAdapter{
  Future saveTombstone(TombstoneHiveEntity tombstoneEntity);
  TombstoneHiveEntity? getTombstone(String objectId, TombstoneModelType tombstoneModelType );
}