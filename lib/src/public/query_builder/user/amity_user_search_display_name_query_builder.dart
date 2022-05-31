import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class AmityUserSearchDisplayNameQueryBuilder {
  late GetAllUserUseCase _useCase;
  String? _keywoard;
  AmityUserSortOption _amityUserSortOption = AmityUserSortOption.DISPLAY;
  AmityUserSearchDisplayNameQueryBuilder(
      {required GetAllUserUseCase useCase, String? keyword}) {
    _useCase = useCase;
    _keywoard = keyword;
  }

  AmityUserSearchDisplayNameQueryBuilder keyword(String keyword) {
    _keywoard = keyword;
    return this;
  }

  AmityUserSearchDisplayNameQueryBuilder sortBy(
      AmityUserSortOption amityUserSortOption) {
    _amityUserSortOption = amityUserSortOption;
    return this;
  }

  Future<List<AmityUser>> query() {
    UsersRequest usersRequest = UsersRequest();

    usersRequest.keyword = _keywoard;

    usersRequest.sortBy = _amityUserSortOption.apiKey;
    usersRequest.filter = 'all';

    // usersRequest.options = Options(limit: 10, token: null);

    return _useCase.get(usersRequest);
  }
}
