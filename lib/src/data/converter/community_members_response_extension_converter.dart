import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/community_member_hive_entity_14.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/community_member_paging_hive_entity_15.dart';
import 'package:amity_sdk/src/data/response/get_community_members_response.dart';

extension CommunityMemmbersResponseExtension on GetCommunityMembersResponse {
  CommunityMemberPagingHiveEntity convertToCommunityMemberPagingHiveEntity() =>
      CommunityMemberPagingHiveEntity()
        ..id = '$hashCode'
        ..communityMemberIds = communityUsers.map((e) => e.userId).toList()
        ..nextToken = paging?.next;
}
