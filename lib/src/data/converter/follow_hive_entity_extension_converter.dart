import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/follow_hive_entity_3.dart';
import 'package:amity_sdk/src/domain/domain.dart';

extension FollowHiveEntityExtension on FollowHiveEntity {
  AmityFollowRelationship convertToAmityFollowRelationship() {
    return AmityFollowRelationship()
      ..sourceUserId = sourceUserId
      ..targetUserId = targetUserId
      ..createdAt = createdAt
      ..status = AmityFollowStatus.values.firstWhere(
          (element) => element.value == status,
          orElse: (() => AmityFollowStatus.NONE));
  }

  bool isMatchingFilter(FollowRequest request) {
    return _statusCondition(request);
  }

  bool _statusCondition(FollowRequest request) {
    return request.status == null || request.status == status;
  }
}
