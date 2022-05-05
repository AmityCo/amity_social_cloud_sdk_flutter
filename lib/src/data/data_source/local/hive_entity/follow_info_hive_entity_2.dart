import 'package:hive/hive.dart';

part 'follow_info_hive_entity_2.g.dart';

@HiveType(typeId: 2)
class FollowInfoHiveEntity {
  String? userId;
  int? followerCount;
  int? followingCount;
  int? pendingCount;
}
