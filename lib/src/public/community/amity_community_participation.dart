import 'package:amity_sdk/src/core/model/api_request/update_community_members_request.dart';
import 'package:amity_sdk/src/domain/usecase/community/member/community_member_add_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/community/member/community_member_remove_usecase.dart';

import '../../core/core.dart';
import '../query_builder/community/member/community_member_query_builder.dart';

class AmityCommunityParticipation {
  final String _communityId;

  AmityCommunityParticipation(this._communityId);

  CommunityMemberQueryBuilder getMembers() {
    return CommunityMemberQueryBuilder(
        usecase: serviceLocator(), communityId: _communityId);
  }

  Future addMembers(List<String> userIds) {
    final request = UpdateCommunityMembersRequest(
        communityId: _communityId, userIds: userIds);
    return serviceLocator<CommunityMemberAddUsecase>().get(request);
  }

  Future removeMembers(List<String> userIds) {
    final request = UpdateCommunityMembersRequest(
        communityId: _communityId, userIds: userIds);
    return serviceLocator<CommunityMemberRemoveUsecase>().get(request);
  }
}
