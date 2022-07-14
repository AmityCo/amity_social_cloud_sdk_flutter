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
  Future<List<AmityUser>> query() {
    UsersRequest usersRequest = UsersRequest();

    usersRequest.keyword = _keywoard;

    usersRequest.sortBy = _amityUserSortOption.apiKey;
    usersRequest.filter = 'all';

    return _useCase.get(usersRequest);
  }
}
