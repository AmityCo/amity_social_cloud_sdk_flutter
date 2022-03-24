import 'package:hive/hive.dart';

part 'feed_paging_hive_entity_10.g.dart';

@HiveType(typeId: 10)
class FeedPagingHiveEntity {
  String? id;
  List<String>? postIds;
  String? nextToken;
  String? prevToken;
}
