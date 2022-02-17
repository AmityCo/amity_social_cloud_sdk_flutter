import 'package:amity_sdk/data/data_source/local/hive_entity/follow_hive_entity_3.dart';
import 'package:amity_sdk/data/response/follow_response.dart';

extension FollowResponseExtension on FollowResponse {
  List<FollowHiveEntity> convertToFollowHiveEntitys() {
    return follows
        .map((e) => FollowHiveEntity()
          ..sourceUserId = e.from
          ..targetUserId = e.to
          ..status = e.status)
        .toList();
  }
}

extension FollowExtension on Follow {
  FollowHiveEntity convertFollowHiveEntity() {
    return FollowHiveEntity()
      ..sourceUserId = from
      ..targetUserId = to
      ..status = status;
  }
}
