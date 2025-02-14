import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// Query builder to search the community memeber using keyword
class AmityCommunityMemberSearch {
  final CommunityMemberQueryUsecase usecase;
  final GetCommunityMembersRequest _request;

  /// Init [CommunityMemberQueryBuilder]
  AmityCommunityMemberSearch(
      {required this.usecase,
      required String communityId,
      required String keyword})
      : _request = GetCommunityMembersRequest(
            communityId: communityId, keyword: keyword);

  /// Apply Filter
  AmityCommunityMemberSearch roles(List<String> roles) {
    _request.roles = roles;
    return this;
  }

  /// Apply Filter
  AmityCommunityMemberSearch filter(AmityCommunityMembershipFilter filter) {
    _request.memberships = filter.memberships;
    return this;
  }

  /// Apply Filter
  AmityCommunityMemberSearch sortBy(AmityCommunityMembershipSortOption order) {
    _request.sortBy = order.apiKey;
    return this;
  }

  /// Apply Filter
  AmityCommunityMemberSearch includeDeleted(bool includeDeleted) {
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
