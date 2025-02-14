import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class AmityUserFollowersQueryBuilder {
  late GetUserFollowersUsecase _useCase;
  late String _userId;
  AmityFollowStatusFilter _status = AmityFollowStatusFilter.ALL;

  AmityUserFollowersQueryBuilder(
      {required GetUserFollowersUsecase useCase, required String userId}) {
    _useCase = useCase;
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

    final data = await _useCase.get(request);

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