import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [CommunityMemberQueryBuilder]
class CommunityMemberQueryBuilder {
  final CommunityMemberQueryUsecase usecase;
  final GetCommunityMembersRequest _request;

  /// Init [CommunityMemberQueryBuilder]
  CommunityMemberQueryBuilder(
      {required this.usecase, required String communityId})
      : _request = GetCommunityMembersRequest(communityId: communityId);

  /// Apply Filter
  CommunityMemberQueryBuilder roles(List<String> roles) {
    _request.roles = roles;
    return this;
  }

  /// Apply Filter
  CommunityMemberQueryBuilder filter(AmityCommunityMembershipFilter filter) {
    _request.memberships = filter.memberships;
    return this;
  }

  /// Apply Filter
  CommunityMemberQueryBuilder sortBy(AmityCommunityMembershipSortOption order) {
    _request.sortBy = order.apiKey;
    return this;
  }

  Future<PageListData<List<AmityCommunityMember>, String>> getPagingData(
      {String? token, int? limit}) async {
    _request.options = OptionsRequest();

    if (token != null) {
      _request.options!.token = token;
    }
    if (limit != null) {
      _request.options!.limit = limit;
    }

    final data = await usecase.get(_request);

    return data;
  }
}
