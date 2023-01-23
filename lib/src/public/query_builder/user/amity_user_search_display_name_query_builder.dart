import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// Query Builder for Search User using display name
class AmityUserSearchDisplayNameQueryBuilder {
  late GetAllUserUseCase _useCase;
  String? _keywoard;
  AmityUserSortOption _amityUserSortOption = AmityUserSortOption.DISPLAY;

  /// Init [AmityUserSearchDisplayNameQueryBuilder]
  AmityUserSearchDisplayNameQueryBuilder(
      {required GetAllUserUseCase useCase, String? keyword}) {
    _useCase = useCase;
    _keywoard = keyword;
  }

  /// Add keyword in search query
  AmityUserSearchDisplayNameQueryBuilder keyword(String keyword) {
    _keywoard = keyword;
    return this;
  }

  /// sory by result
  AmityUserSearchDisplayNameQueryBuilder sortBy(
      AmityUserSortOption amityUserSortOption) {
    _amityUserSortOption = amityUserSortOption;
    return this;
  }

  /// Query Result
  Future<List<AmityUser>> query() async {
    UsersRequest usersRequest = UsersRequest();

    usersRequest.keyword = _keywoard;

    usersRequest.sortBy = _amityUserSortOption.value;
    usersRequest.filter = 'all';

    final amityUsers = await _useCase.get(usersRequest);

    return amityUsers.data;
  }

  Future<PageListData<List<AmityUser>, String>> getPagingData(
      {String? token, int? limit}) async {
    UsersRequest usersRequest = UsersRequest();

    usersRequest.keyword = _keywoard;

    usersRequest.sortBy = _amityUserSortOption.value;
    usersRequest.filter = 'all';

    usersRequest.options = OptionsRequest();
    if (token != null) {
      usersRequest.options!.token = token;
    }
    if (limit != null) {
      usersRequest.options!.limit = limit;
    }

    return _useCase.get(usersRequest);
  }
}
