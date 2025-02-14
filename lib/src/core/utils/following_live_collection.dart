import 'dart:async';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/usecase/relationship/following_user_observe_list_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class FollowingLiveCollection extends LiveCollection<AmityFollowRelationship> {
  RequestBuilder<FollowRequest> request;

  FollowingLiveCollection({required this.request});

  @protected
  @override
  Future<PageListData<List<AmityFollowRelationship>, String>>
      getFirstPageRequest() async {
    final params = request();
    params.options?.token = null;
    params.options?.limit = defaultPageSize;
    return await serviceLocator<GetUserFollowingsUsecase>().get(params);
  }

  @override
  StreamController<List<AmityFollowRelationship>> getStreamController() {
    return serviceLocator<FollowingUserObserveListUseCase>().listen(request);
  }

  @protected
  @override
  Future<PageListData<List<AmityFollowRelationship>, String>>
      getNextPageRequestInternal(String? token) async {
    final params = request();
    params.options?.token = token;
    params.options?.limit = null;
    return await serviceLocator<GetUserFollowingsUsecase>().get(params);
  }

  // TODO: when switching to follower livecollection in UIKit cause app to freeze
  // @override
  // StreamController<PagingIdHiveEntity> observeNewItem() {
  //   return serviceLocator<FollowingObserveNewItemUsecase>().listen(request);
  // }
}
