import '../../core/core.dart';
import '../query_builder/community/member/community_member_query_builder.dart';

class AmityCommunityParticipation {
  final String communityId;

  AmityCommunityParticipation({required this.communityId});

  CommunityMemberQueryBuilder getMembers() {
    return CommunityMemberQueryBuilder(
        usecase: serviceLocator(), communityId: communityId);
  }

  //addMembers
  //removeMembers
}
