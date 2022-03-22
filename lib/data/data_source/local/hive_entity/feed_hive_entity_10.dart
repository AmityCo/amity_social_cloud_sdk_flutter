import 'package:hive/hive.dart';

part 'feed_hive_entity_10.g.dart';

@HiveType(typeId: 10)
class FeedHiveEntity {
  String? id;
  List<String>? postIds;
  String? nextToken;
  String? prevToken;
}
