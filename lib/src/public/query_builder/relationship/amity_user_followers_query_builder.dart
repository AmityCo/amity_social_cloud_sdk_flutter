import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/usecase/relationship/get_user_followers_legacy_usecase.dart';

class AmityUserFollowersQueryBuilder {
  late GetUserFollowersLegacyUsecase _legacyUseCase;
  late String _userId;
  AmityFollowStatusFilter _status = AmityFollowStatusFilter.ALL;

  AmityUserFollowersQueryBuilder(
      {required GetUserFollowersLegacyUsecase legacyUseCase, required String userId}) {
    _legacyUseCase = legacyUseCase;
    _userId = userId;
  }

  AmityUserFollowersQueryBuilder status(AmityFollowStatusFilter status) {
    _status = status;
    return this;
  }

  Future<PageListData<List<AmityFollowRelationship>, String>> getPagingData(
      {String? token, int? limit}) async {
    final request = FollowRequest();
    request.userId = _userId;
    request.status = _status.value;

    if (token != null) {
      request.token = token;
    }
    if (limit != null) {
      request.limit = limit;
    }

    final data = await _legacyUseCase.get(request);

    return data;
  }

  FollowerLiveCollection getLiveCollection() {
    final request = FollowRequest();
    request.userId = _userId;
    request.status = _status.value;

    // request.stackFromEnd = stackFromEnd;

    request.options = OptionsRequest();

    // request.options!.type = 'scrollable';
    // if (!_stackFromEnd) {
    //   request.options!.first = pageSize;
    // } else {
    //   request.options!.last = pageSize;
    // }

    return FollowerLiveCollection(
      request: () => request,
    );
  }

}