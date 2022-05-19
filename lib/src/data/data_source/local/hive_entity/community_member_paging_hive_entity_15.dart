import 'package:hive/hive.dart';

part 'community_member_paging_hive_entity_15.g.dart';

@HiveType(typeId: 15)
class CommunityMemberPagingHiveEntity {
  String? id;
  List<String>? communityMemberIds;
  String? nextToken;
  String? prevToken;
}
