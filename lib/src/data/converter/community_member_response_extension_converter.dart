import 'package:amity_sdk/src/data/data.dart';
import '../data_source/local/hive_entity/community_member_hive_entity_14.dart';

extension CommunityMemberResponseExtension on CommunityUserResponse {
  CommnityMemberHiveEntity convertToCommnityMemberHiveEntity() {
    return CommnityMemberHiveEntity()
      ..communityId = communityId
      ..channelId = channelId
      ..communityMembership = communityMembership
      ..permissions = permissions
      ..roles = roles;
  }
}
