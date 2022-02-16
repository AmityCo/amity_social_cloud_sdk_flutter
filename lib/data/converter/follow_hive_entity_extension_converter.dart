import 'package:amity_sdk/data/data_source/local/hive_entity/follow_hive_entity_3.dart';
import 'package:amity_sdk/domain/model/amity_follow_relationship.dart';

extension FollowHiveEntityExtension on FollowHiveEntity {
  AmityFollowRelationship convertToAmityFollowRelationship() {
    return AmityFollowRelationship();
  }
}
