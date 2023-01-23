import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// Query Builder to Get All Amity User
class AmityAllUserQueryBuilder {
  late GetAllUserUseCase _useCase;
  String? _keywoard;
  AmityUserSortOption _amityUserSortOption = AmityUserSortOption.DISPLAY;

  /// Init All User Query Builder
  AmityAllUserQueryBuilder(
      {required GetAllUserUseCase useCase, String? keyword}) {
    _useCase = useCase;
    _keywoard = keyword;
  }

  /// Sort By user
  AmityAllUserQueryBuilder sortBy(AmityUserSortOption amityUserSortOption) {
    _amityUserSortOption = amityUserSortOption;
    return this;
  }

  /// Query User
  Future<List<AmityUser>> query() async {
    UsersRequest usersRequest = UsersRequest();

    usersRequest.keyword = _keywoard;

    usersRequest.sortBy = _amityUserSortOption.value;
    usersRequest.filter = 'all';

    // usersRequest.options = Options(limit: 10, token: null);

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
