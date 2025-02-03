import 'dart:async';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/usecase/comment/comment_fetch_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/comment/comment_observe_new_item_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/comment/comment_observe_usecase.dart';
import 'package:flutter/foundation.dart';

class CommentLiveCollection extends LiveCollection<AmityComment> {
  RequestBuilder<GetCommentRequest> request;

  CommentLiveCollection({required this.request});

  @protected
  @override
  Future<PageListData<List<AmityComment>, String>> getFirstPageRequest() async {
    final params = request();
    params.options?.token = null;
    params.options?.limit = defaultPageSize;
    return await serviceLocator<CommentFetchUseCase>().get(params);
  }

  @protected
  @override
  Future<PageListData<List<AmityComment>, String>> getNextPageRequestInternal(
      String? token) async {
    final params = request();
    params.options?.token = token;
    params.options?.limit = null;
    return await serviceLocator<CommentFetchUseCase>().get(params);
  }

  @override
  StreamController<List<AmityComment>> getStreamController() {
    return serviceLocator<CommentObserveUseCase>().listen(request);
  }
  
  @protected
  @override
  StreamController<PagingIdHiveEntity> observeNewItem() {
    return serviceLocator<CommentObserveNewItemUseCase>().listen(request);
  }
}