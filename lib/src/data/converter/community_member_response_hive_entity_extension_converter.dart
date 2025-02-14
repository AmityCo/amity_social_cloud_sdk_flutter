import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/community_member_hive_entity_14.dart';
import 'package:amity_sdk/src/domain/domain.dart';

extension CommunityMemberHiveEntityExtension on CommunityMemberHiveEntity {
  AmityCommunityMember convertToAmityCommunityMember() {
    return AmityCommunityMember()
      ..communityId = communityId
      ..channelId = channelId
      ..userId = userId
      ..roles = roles
      ..isBanned = isBanned
      ..isDeleted = isDeleted ?? false; // If isDeleted is null, set it to false to avoid null value
  }

  bool isMatchingFilter(GetCommunityMembersRequest request) {
    return isMatchingCommunityId(request.communityId) &&
        isMatchingCommunityMembership(request.memberships) &&
        isMatchingRoles(request.roles) &&
        isMatchingDelected(request.isDeleted);
  }

  bool isMatchingCommunityId(String? communityId) {
    if (communityId == null) return true;
    return this.communityId == communityId;
  }

  bool isMatchingCommunityMembership(List<String>? communityMemberships) {
    if (communityMemberships == null) return true;
    return communityMemberships.contains(communityMembership);
  }

  bool isMatchingRoles(List<String>? roles) {
    if (roles == null) return true;
    return roles.every((role) => this.roles!.contains(role));
  }

  bool isMatchingDelected(bool? isDeleted) {
    if (isDeleted == null) return true;
    return this.isDeleted == isDeleted;
  }
}
