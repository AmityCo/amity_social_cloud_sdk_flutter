import 'package:amity_sdk/src/data/data_source/local/hive_entity/follow_hive_entity_3.dart';
import 'package:amity_sdk/src/data/response/follow_response.dart';

extension FollowResponseExtension on FollowResponse {
  List<FollowHiveEntity> convertToFollowHiveEntitys() {
    return follows
        .map((e) => FollowHiveEntity()
          ..id = '${e.from}_${e.to}'
          ..sourceUserId = e.from
          ..targetUserId = e.to
          ..status = e.status
          ..createdAt = e.createdAt
          ..updatedAt = e.updatedAt)
        .toList();
  }
}

extension FollowExtension on Follow {
  FollowHiveEntity convertFollowHiveEntity() {
    return FollowHiveEntity()
      ..id = '${from}_$to'
      ..sourceUserId = from
      ..targetUserId = to
      ..status = status
      ..createdAt = createdAt
      ..updatedAt = updatedAt;
  }
}
