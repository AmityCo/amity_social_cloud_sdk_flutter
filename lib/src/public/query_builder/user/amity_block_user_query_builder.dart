import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// Query Builder to Get All Amity User
class AmityBlockUserQueryBuilder {
  late GetBlockUserUseCase _useCase;

  /// Init All User Query Builder
  AmityBlockUserQueryBuilder({required GetBlockUserUseCase useCase}) {
    _useCase = useCase;
  }

  /// Query User
  Future<List<AmityUser>> query() async {
    final amityUsers = await _useCase.get(null);

    return amityUsers.data;
  }

  Future<PageListData<List<AmityUser>, String>> getPagingData({String? token, int? limit}) async {
    return _useCase.get(null);
  }
}
