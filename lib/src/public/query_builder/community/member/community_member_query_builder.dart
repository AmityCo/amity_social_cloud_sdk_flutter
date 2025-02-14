import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/utils/community_member_live_collection.dart';
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

  CommunityMemberQueryBuilder includeDeleted(bool includeDeleted) {
    _request.isDeleted = (includeDeleted) ? null : false;
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

  Future<List<AmityCommunityMember>> query({String? token, int? limit}) async {
    _request.options = OptionsRequest();

    if (token != null) {
      _request.options!.token = token;
    }
    if (limit != null) {
      _request.options!.limit = limit;
    }

    final data = await usecase.get(_request);

    return data.data;
  }

  GetCommunityMembersRequest build({int? pageSize = 20}) {
    GetCommunityMembersRequest request =
        GetCommunityMembersRequest(communityId: _request.communityId,
        keyword: _request.keyword,
        memberships: _request.memberships,
        roles: _request.roles,
        sortBy: _request.sortBy,
        isDeleted: _request.isDeleted,
        options: OptionsRequest(limit: pageSize)
        );

    return request;
  }

  CommunityMemberLiveCollection getLiveCollection({int? pageSize = 20}) {
    return CommunityMemberLiveCollection(request: () => build(pageSize: pageSize));
  }
}
