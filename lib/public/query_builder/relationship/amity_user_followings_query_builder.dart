import 'package:amity_sdk/domain/domain.dart';

class AmityUserFollowingsQueryBuilder {
  late GetUserFollowingsUsecase _useCase;
  late String _userId;
  AmityUserFollowingsQueryBuilder(
      {required GetUserFollowingsUsecase useCase, required String userId}) {
    _useCase = useCase;
    _userId = userId;
  }

  Future<List<AmityFollowRelationship>> query() {
    return _useCase.get(_userId);
  }
}
