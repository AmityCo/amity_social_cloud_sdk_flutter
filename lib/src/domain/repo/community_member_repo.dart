import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/model/api_request/get_community_members_request.dart';
import 'package:amity_sdk/src/domain/domain.dart';

abstract class CommunityMemberRepo {
  Future<Tuple2<List<AmityCommunityMember>, String>> queryMembers(
      GetCommunityMembersRequest request);

  //TODO: move to community?
  // Future<AmityCommunityMember> addMember();
  // Future removeMember();
  // Future joinCommunity(String communityId);
  // Future leaveCommunity(String communityId);

}
