import 'dart:async';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/utils/amity_nonce.dart';
import 'package:amity_sdk/src/data/data_source/data_source.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/usecase/community/community_fetch_list_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/community/community_observe_list_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/community/community_observe_new_item_usecase.dart';
import 'package:flutter/foundation.dart';

class CommunityLiveCollection extends LiveCollection<AmityCommunity> {
  RequestBuilder<GetCommunityRequest> request;

  CommunityLiveCollection({required this.request});

  @override
  AmityNonce getNonce() {
    return request().getNonce();
  }

  @override
  int getHash() {
    return request().getHashCode();
  }

  @Deprecated('This function will not be available in the future, please use implementation from https://docs.social.plus/social-plus-sdk/social/communities/query-communities instead')
  @protected
  @override
  Future<PageListData<List<AmityCommunity>, String>>
      getFirstPageRequest() async {
    final params = request();
    params.options?.token = null;
    return await serviceLocator<CommunityFetchListUseCase>().get(params);
  }

  @Deprecated('This function will not be available in the future, please use implementation from https://docs.social.plus/social-plus-sdk/social/communities/query-communities instead')
  @protected
  @override
  Future<PageListData<List<AmityCommunity>, String>> getNextPageRequestInternal(
      String? token) async {
    final params = request();
    params.options?.token = token;
    params.options?.limit = null;
    return await serviceLocator<CommunityFetchListUseCase>().get(params);
  }

  @Deprecated('This function will not be available in the future, please use implementation from https://docs.social.plus/social-plus-sdk/social/communities/query-communities instead')
  @override
  Future<PageListData<List<AmityCommunity>, String>> getNextPageRequest(
      String? token) async {
    final params = request();
    if (token ==null) {
      params.options?.token = null;
      params.options?.limit = defaultPageSize;
    } else {
      params.options?.token = token;   
      params.options?.limit = null; 
    }
    return await serviceLocator<CommunityGetQueryUseCase>().get(request());
  }

  @override
  StreamController<List<AmityCommunity>> getStreamController() {
    return serviceLocator<CommunityObserveListUseCase>().listen(request);
  }

  @override
  StreamController<PagingIdHiveEntity> observeNewItem() {
    return serviceLocator<CommunityObserveNewItemUsecase>().listen(request);
  }
}
