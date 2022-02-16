import 'package:amity_sdk/data/data_source/local/hive_entity/follow_hive_entity_3.dart';
import 'package:amity_sdk/data/response/follow_response.dart';

extension FollowResponseExtension on FollowResponse {
  FollowHiveEntity convertToFollowHiveEntity() {
    return FollowHiveEntity();
  }
}
