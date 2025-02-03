import 'dart:async';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/utils/amity_nonce.dart';
import 'package:amity_sdk/src/data/data_source/data_source.dart';
import 'package:amity_sdk/src/domain/usecase/reaction/reaction_observe_new_item_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/reaction/reaction_observe_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/reaction/reaction_query_usecase.dart';
import 'package:flutter/foundation.dart';

class ReactionLiveCollection extends LiveCollection<AmityReaction> {
  RequestBuilder<GetReactionRequest> request;

  ReactionLiveCollection({required this.request});

  @override
  AmityNonce getNonce() {
    return request().getNonce();
  }

  @override
  int getHash() {
    return request().getHashCode();
  }

  @protected
  @override
  Future<PageListData<List<AmityReaction>, String>> getFirstPageRequest() async {
    final params = request();
    params.options?.token = null;
    return await serviceLocator<ReactionQueryUsecase>().get(params);
  }

  @protected
  @override
  Future<PageListData<List<AmityReaction>, String>> getNextPageRequestInternal(
      String? token) async {
    final params = request();
    params.options?.token = token;
    params.options?.limit = null;
    return await serviceLocator<ReactionQueryUsecase>().get(params);
  }

  @override
  StreamController<List<AmityReaction>> getStreamController() {
    return serviceLocator<ReactionObserveUseCase>().listen(request);
  }

  @protected
  @override
  StreamController<PagingIdHiveEntity> observeNewItem() {
    return serviceLocator<ReactionObserveNewItemUseCase>().listen(request);
  }
}