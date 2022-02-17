import 'package:amity_sdk/domain/domain.dart';

class AmityUserFollowersQueryBuilder {
  late GetUserFollowersUsecase _useCase;
  late String _userId;
  AmityUserFollowersQueryBuilder(
      {required GetUserFollowersUsecase useCase, required String userId}) {
    _useCase = useCase;
    _userId = userId;
  }

  Future<List<AmityFollowRelationship>> query() {
    return _useCase.get(_userId);
  }
}
