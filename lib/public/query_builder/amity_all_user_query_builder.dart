import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';

class AmityAllUserQueryBuilder {
  late GetAllUserUseCase _useCase;
  String? _keywoard;
  AmityUserSortOption _amityUserSortOption = AmityUserSortOption.DISPLAY;
  AmityAllUserQueryBuilder(
      {required GetAllUserUseCase useCase, String? keyword}) {
    _useCase = useCase;
    _keywoard = keyword;
  }
  AmityAllUserQueryBuilder sortBy(AmityUserSortOption amityUserSortOption) {
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
