import 'package:amity_sdk/domain/model/amity_follow_relationship.dart';
import 'package:amity_sdk/domain/usecase/relationship/get_user_followings_usecase.dart';

class AmityUserFollowersQueryBuilder {
  late GetUserFollowingsUsecase _useCase;
  late String _userId;
  AmityUserFollowersQueryBuilder(
      {required GetUserFollowingsUsecase useCase, required String userId}) {
    _useCase = useCase;
    _userId = userId;
  }

  Future<List<AmityFollowRelationship>> query() {
    return _useCase.get(_userId);
  }
}
