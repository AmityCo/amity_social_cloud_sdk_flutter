// ignore_for_file: unused_field

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/usecase/relationship/get_my_followers_legacy_usecase.dart';

class AmityMyFollowersQueryBuilder {
  late GetMyFollowersLegacyUsecase _legacyUseCase;
  AmityFollowStatusFilter _status = AmityFollowStatusFilter.ALL;

  AmityMyFollowersQueryBuilder({required GetMyFollowersLegacyUsecase legacyUseCase}) {
    _legacyUseCase = legacyUseCase;
  }

  AmityMyFollowersQueryBuilder status(AmityFollowStatusFilter status) {
    _status = status;
    return this;
  }

  Future<PageListData<List<AmityFollowRelationship>, String>> getPagingData(
      {String? token, int? limit}) async {
    final request = FollowRequest();
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
