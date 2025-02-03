import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/model/api_request/query_global_pinned_post_request.dart';
import 'package:amity_sdk/src/domain/model/amity_pinned_post.dart';
import 'package:amity_sdk/src/domain/usecase/pin/global_pinned_post_observe_query_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/pin/global_pinned_post_query_usecase.dart';
import 'package:flutter/foundation.dart';

class GlobalPinnedPostLiveCollection extends LiveCollection<AmityPinnedPost> {
  RequestBuilder<QueryGlobalPinnedPostRequest> request;

  GlobalPinnedPostLiveCollection({required this.request});

  @protected
  @override
  Future<PageListData<List<AmityPinnedPost>, String>>
      getFirstPageRequest() async {
    final params = request();
    return await serviceLocator<GlobalPinnedPostQueryUseCase>().get(params);
  }

  @protected
  @override
  Future<PageListData<List<AmityPinnedPost>, String>> getNextPageRequestInternal(
      String? token) async {
    return Future.value(PageListData([], ''));
  }

  @override
  StreamController<List<AmityPinnedPost>> getStreamController() {
    return serviceLocator<GlobalPinnedPostObserveQueryUseCase>()
        .listen(request);
  }
}
