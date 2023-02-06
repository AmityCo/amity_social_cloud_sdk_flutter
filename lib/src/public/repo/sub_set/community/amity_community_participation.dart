import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

/// Repo To add and remove member from the Community
class AmityCommunityParticipation {
  final String _communityId;

  /// Init AmityCommunityParticipation
  AmityCommunityParticipation(this._communityId);

  /// Get Community Member
  CommunityMemberQueryBuilder getMembers() {
    return CommunityMemberQueryBuilder(
        usecase: serviceLocator(), communityId: _communityId);
  }

  /// Search Community Member
  AmityCommunityMemberSearch searchMembers(String keyword) {
    return AmityCommunityMemberSearch(
        usecase: serviceLocator(), communityId: _communityId, keyword: keyword);
  }

  /// Add Member to community
  Future addMembers(List<String> userIds) {
    final request = UpdateCommunityMembersRequest(
        communityId: _communityId, userIds: userIds);
    return serviceLocator<CommunityMemberAddUsecase>().get(request);
  }

  /// Remove member from the community
  Future removeMembers(List<String> userIds) {
    final request = UpdateCommunityMembersRequest(
        communityId: _communityId, userIds: userIds);
    return serviceLocator<CommunityMemberRemoveUsecase>().get(request);
  }
}
