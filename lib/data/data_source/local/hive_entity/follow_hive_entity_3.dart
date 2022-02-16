import 'package:hive/hive.dart';

@HiveType(typeId: 3)
class FollowHiveEntity {
  String? id;
  String? sourceUserId;
  String? targetUserId;
  String? status;
}
