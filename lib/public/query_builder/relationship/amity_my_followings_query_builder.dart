// ignore_for_file: unused_field

import 'package:amity_sdk/core/enum/amity_follow_status_filter.dart';
import 'package:amity_sdk/domain/model/amity_follow_relationship.dart';
import 'package:amity_sdk/domain/usecase/relationship/get_my_followings_usecase.dart';

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
