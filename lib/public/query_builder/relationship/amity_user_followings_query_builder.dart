import 'package:amity_sdk/domain/model/amity_follow_relationship.dart';
import 'package:amity_sdk/domain/usecase/relationship/get_user_followers_usecase.dart';

class AmityUserFollowingsQueryBuilder {
  late GetUserFollowersUsecase _useCase;
  late String _userId;
  AmityUserFollowingsQueryBuilder(
      {required GetUserFollowersUsecase useCase, required String userId}) {
    _useCase = useCase;
    _userId = userId;
  }

  Future<List<AmityFollowRelationship>> query() {
    return _useCase.get(_userId);
  }
}
