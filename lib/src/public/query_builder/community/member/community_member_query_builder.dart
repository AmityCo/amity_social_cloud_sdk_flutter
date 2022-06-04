import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/usecase/community/member/community_member_query_usecase.dart';

class CommunityMemberQueryBuilder {
  final CommunityMemberQueryUsecase usecase;
  final GetCommunityMembersRequest _request;

  CommunityMemberQueryBuilder(
      {required this.usecase, required String communityId})
      : _request = GetCommunityMembersRequest(communityId: communityId);

  CommunityMemberQueryBuilder roles(List<String> roles) {
    _request.roles = roles;
    return this;
  }

  CommunityMemberQueryBuilder filter(AmityCommunityMembershipFilter filter) {
    _request.memberships = filter.memberships;
    return this;
  }

  CommunityMemberQueryBuilder sortBy(AmityMembershipSortOption order) {
    _request.sortBy = order.value;
    return this;
  }

  Future<Tuple2<List<AmityCommunityMember>, String>> getPagingData(
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
