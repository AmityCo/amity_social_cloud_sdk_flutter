import 'package:amity_sdk/src/src.dart';
import 'package:hive/hive.dart';

part 'follow_info_hive_entity_2.g.dart';

@HiveType(typeId: 2)
class FollowInfoHiveEntity extends  EkoObject {
  String? userId;
  int? followerCount;
  int? followingCount;
  int? pendingCount;
  String? status;
  
  @override
  String? getId() {
    return userId;
  }
}
