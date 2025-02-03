import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/model/api_request/query_pinned_post_request.dart';
import 'package:amity_sdk/src/domain/model/amity_pinned_post.dart';
import 'package:amity_sdk/src/domain/usecase/pin/pinned_post_observe_query_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/pin/pinned_post_query_usecase.dart';
import 'package:flutter/foundation.dart';

class PinnedPostLiveCollection extends LiveCollection<AmityPinnedPost> {
  RequestBuilder<QueryPinnedPostRequest> request;

  PinnedPostLiveCollection({required this.request});

  @protected
  @override
  Future<PageListData<List<AmityPinnedPost>, String>>
      getFirstPageRequest() async {
    final params = request();
    return await serviceLocator<PinnedPostQueryUseCase>().get(params);
  }

  @protected
  @override
  Future<PageListData<List<AmityPinnedPost>, String>> getNextPageRequestInternal(
      String? token) async {
    return Future.value(PageListData([], ''));
  }

  @override
  StreamController<List<AmityPinnedPost>> getStreamController() {
    return serviceLocator<PinnedPostObserveQueryUseCase>().listen(request);
  }
}