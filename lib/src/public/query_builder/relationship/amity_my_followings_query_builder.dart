import 'package:amity_sdk/src/core/enum/amity_follow_status_filter.dart';
import 'package:amity_sdk/src/domain/model/amity_follow_relationship.dart';
import 'package:amity_sdk/src/domain/usecase/relationship/get_my_followings_usecase.dart';

class AmityMyFollowingsQueryBuilder {
  late GetMyFollowingsUsecase _useCase;
  AmityFollowStatusFilter _status = AmityFollowStatusFilter.ALL;

  AmityMyFollowingsQueryBuilder({required GetMyFollowingsUsecase useCase}) {
    _useCase = useCase;
  }

  AmityMyFollowingsQueryBuilder status(AmityFollowStatusFilter status) {
    _status = status;
    return this;
  }

  Future<List<AmityFollowRelationship>> query() {
    return _useCase.get();
  }
}
