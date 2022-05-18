import 'package:hive/hive.dart';

part 'community_feed_hive_13.g.dart';

@HiveType(typeId: 13)
class CommunityFeedHiveEntity extends HiveObject {
  String? feedId;
  String? feedType;
  String? targetId;
  String? targetType;
  int? postCount;
}
