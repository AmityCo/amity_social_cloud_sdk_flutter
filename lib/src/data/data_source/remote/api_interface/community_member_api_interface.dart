import 'package:amity_sdk/src/core/model/api_request/get_community_members_request.dart';
import 'package:amity_sdk/src/core/model/api_request/update_community_members_request.dart';
import 'package:amity_sdk/src/core/model/api_request/update_community_role_request.dart';
import 'package:amity_sdk/src/data/response/get_community_members_response.dart';

abstract class CommunityMemmberApiInterface {
  Future<GetCommunityMembersResponse> getCommunityMembers(
      GetCommunityMembersRequest request);
  Future<GetCommunityMembersResponse> joinCommunity(String communityId);
  Future<GetCommunityMembersResponse> leaveCommunity(String communityId);
  Future<GetCommunityMembersResponse> addMember(
      UpdateCommunityMembersRequest request);
  Future<GetCommunityMembersResponse> removeMember(
      UpdateCommunityMembersRequest request);
  Future<GetCommunityMembersResponse> addRole(
      UpdateCommunityRoleRequest request);
  Future<GetCommunityMembersResponse> removeRole(
      UpdateCommunityRoleRequest request);
  Future<GetCommunityMembersResponse> banMember(
      UpdateCommunityMembersRequest request);
  Future<GetCommunityMembersResponse> unbanMember(
      UpdateCommunityMembersRequest request);
}
