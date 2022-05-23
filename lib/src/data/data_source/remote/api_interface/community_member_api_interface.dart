import 'package:amity_sdk/src/core/model/api_request/get_community_members_request.dart';
import 'package:amity_sdk/src/core/model/api_request/update_community_members_request.dart';
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
}
