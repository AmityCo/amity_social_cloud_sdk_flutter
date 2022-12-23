import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class AmityChannelMemberSearch {
  /// Use case
  final ChannelMemberSearchUsecase useCase;

  /// Channel ID
  final String channelId;

  /// Filter by roles
  AmityRoles? _roles;

  /// filter by membership type
  List<AmityChannelMembership> _channelMembership = [
    AmityChannelMembership.MEMBER
  ];

  /// sort the filter option
  AmityMembershipSortOption _sortOption =
      AmityMembershipSortOption.LAST_CREATED;

  /// Keyword
  String? _keyword;

  /// Init [AmityChannelMemberSearch]
  AmityChannelMemberSearch(this.useCase, this.channelId);

  /// Apply Filter
  AmityChannelMemberSearch membershipFilter(
      List<AmityChannelMembership> channelMembership) {
    _channelMembership = channelMembership;
    return this;
  }

  /// Apply Filter
  AmityChannelMemberSearch roles(List<String> roles) {
    _roles = AmityRoles(roles: roles);
    return this;
  }

  /// Apply Filter
  AmityChannelMemberSearch role(String role) {
    _roles = AmityRoles(roles: [role]);
    return this;
  }

  /// Apply Filter
  AmityChannelMemberSearch sortBy(AmityMembershipSortOption sort) {
    _sortOption = sort;
    return this;
  }

  ///Keyword
  AmityChannelMemberSearch keyword(String keyword) {
    _keyword = keyword;
    return this;
  }

  Future<PageListData<List<AmityChannelMember>, String>> getPagingData(
      {String? token, int? limit}) async {
    final request = GetChannelMembersRequestV4(channelId: channelId);

    request.memberships = _channelMembership.map((e) => e.value).toList();
    request.sortBy = _sortOption.value;
    request.keyword = _keyword;

    if (_roles != null) request.roles = _roles!.roles;

    request.options = OptionsRequest();

    if (token != null) {
      request.options!.token = token;
    }
    if (limit != null) {
      request.options!.limit = limit;
    }

    final data = await useCase.get(request);

    return data;
  }
}
