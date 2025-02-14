import 'dart:async';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/usecase/relationship/follower_user_observe_list_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class FollowerLiveCollection extends LiveCollection<AmityFollowRelationship> {
  RequestBuilder<FollowRequest> request;

  FollowerLiveCollection({required this.request});

  @protected
  @override
  Future<PageListData<List<AmityFollowRelationship>, String>>
      getFirstPageRequest() async {
    final params = request();
    params.options?.token = null;
    params.options?.limit = defaultPageSize;
    return await serviceLocator<GetUserFollowersUsecase>().get(params);
  }

  @override
  StreamController<List<AmityFollowRelationship>> getStreamController() {
    return serviceLocator<FollowerUserObserveListUseCase>().listen(request);
  }

  @protected
  @override
  Future<PageListData<List<AmityFollowRelationship>, String>>
      getNextPageRequestInternal(String? token) async {
    final params = request();
    params.options?.token = token;
    params.options?.limit = null;
    return await serviceLocator<GetUserFollowersUsecase>().get(params);
  }

  // TODO: when switching to following livecollection in UIKit cause app to freeze
  // @override
  // StreamController<PagingIdHiveEntity> observeNewItem() {
  //   return serviceLocator<FollowerObserveNewItemUsecase>().listen(request);
  // }
}
