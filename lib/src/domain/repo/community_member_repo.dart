import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/model/api_request/get_community_members_request.dart';
import 'package:amity_sdk/src/core/model/api_request/update_community_members_request.dart';
import 'package:amity_sdk/src/core/model/api_request/update_community_role_request.dart';
import 'package:amity_sdk/src/domain/domain.dart';

abstract class CommunityMemberRepo {
  Future<Tuple2<List<AmityCommunityMember>, String>> queryMembers(
      GetCommunityMembersRequest request);
  Future addMember(UpdateCommunityMembersRequest request);
  Future removeMember(UpdateCommunityMembersRequest request);
  Future joinCommunity(String communityId);
  Future leaveCommunity(String communityId);
  Future addRole(UpdateCommunityRoleRequest request);
  Future removeRole(UpdateCommunityRoleRequest request);
  List<String>? getMemberPermission(String communityId, String userId);
  Future<AmityCommunityMember> getCommunityMember(
      String communityId, String userId);
  Future banMember(UpdateCommunityMembersRequest request);
  Future unbanMember(UpdateCommunityMembersRequest request);
  Future<AmityCommunityMember> getMember(String communityId, String userId);
}
