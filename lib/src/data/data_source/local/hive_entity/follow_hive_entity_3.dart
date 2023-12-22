import 'package:amity_sdk/src/src.dart';
import 'package:hive/hive.dart';

part 'follow_hive_entity_3.g.dart';

@HiveType(typeId: 3)
class FollowHiveEntity extends EkoObject {
  String? id;
  String? sourceUserId;
  String? targetUserId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  
  @override
  String? getId() {
    return id;
  }
}
