import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// Get Channel Query Builder
class GetChannelMemberQueryBuilder {
  /// Use case
  final ChannelMemberQueryUsecase useCase;

  /// Channel ID
  final String channelId;

  /// Filter by roles
  AmityRoles? _roles;

  /// filter by membership type
  AmityChannelMembershipFilter _fileter = AmityChannelMembershipFilter.ALL;

  /// sort the filter option
  AmityMembershipSortOption _sortOption =
      AmityMembershipSortOption.LAST_CREATED;

  /// Init [GetChannelMemberQueryBuilder]
  GetChannelMemberQueryBuilder(this.useCase, this.channelId);

  /// Apply Filter
  GetChannelMemberQueryBuilder filter(AmityChannelMembershipFilter filter) {
    _fileter = filter;
    return this;
  }

  /// Apply Filter
  GetChannelMemberQueryBuilder roles(List<String> roles) {
    _roles = AmityRoles(roles: roles);
    return this;
  }

  /// Apply Filter
  GetChannelMemberQueryBuilder role(String role) {
    _roles = AmityRoles(roles: [role]);
    return this;
  }

  /// Apply Filter
  GetChannelMemberQueryBuilder sortBy(AmityMembershipSortOption sort) {
    _sortOption = sort;
    return this;
  }

  Future<PageListData<List<AmityChannelMember>, String>> getPagingData(
      {String? token, int? limit}) async {
    GetChannelMembersRequest request =
        GetChannelMembersRequest(channelId: channelId);

    request.filter = _fileter.value;
    request.sortBy = _sortOption.value;

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
