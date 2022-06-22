import 'package:hive/hive.dart';

part 'follow_hive_entity_3.g.dart';

@HiveType(typeId: 3)
class FollowHiveEntity extends HiveObject {
  String? id;
  String? sourceUserId;
  String? targetUserId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
}
