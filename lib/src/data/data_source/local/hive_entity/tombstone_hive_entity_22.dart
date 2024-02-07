import 'package:amity_sdk/src/data/data.dart';
import 'package:hive/hive.dart';


part 'tombstone_hive_entity_22.g.dart';

@HiveType(typeId: 23)
class TombstoneHiveEntity extends EkoObject  {

  String? objectId = null;
  int? errorCode = null;
  String? modelType = null;

  TombstoneHiveEntity({this.errorCode , this.modelType , this.objectId});

  @override
  String? getId() {
    return "$objectId$modelType";
  }
}
