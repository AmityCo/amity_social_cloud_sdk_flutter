import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/data/data_source/local/hive_entity/follow_hive_entity_3.dart';
import 'package:amity_sdk/domain/domain.dart';

extension FollowHiveEntityExtension on FollowHiveEntity {
  AmityFollowRelationship convertToAmityFollowRelationship() {
    return AmityFollowRelationship()
      ..sourceUserId = sourceUserId
      ..targetUserId = targetUserId
      ..status = AmityFollowStatus.values.firstWhere(
          (element) => element.value == status,
          orElse: (() => AmityFollowStatus.NONE));
  }
}
