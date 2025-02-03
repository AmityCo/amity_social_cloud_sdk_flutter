import 'dart:async';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/usecase/feed/global_feed_observe_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/feed/global_feed_query_usecase.dart';
import 'package:flutter/foundation.dart';

class GlobalFeedLiveCollection extends LiveCollection<AmityPost> {
  RequestBuilder<GetGlobalFeedRequest> request;

  GlobalFeedLiveCollection({required this.request});

  @protected
  @override
  Future<PageListData<List<AmityPost>, String>> getFirstPageRequest() async {
    final params = request();
    params.token = null;
    params.limit = defaultPageSize;
    return await serviceLocator<GlobalFeedQueryUsecase>().get(params);
  }

  @protected
  @override
  Future<PageListData<List<AmityPost>, String>> getNextPageRequestInternal(
      String? token) async {
    final params = request();
    params.token = token;
    params.limit = null;
    return await serviceLocator<GlobalFeedQueryUsecase>().get(params);
  }

  @override
  StreamController<List<AmityPost>> getStreamController() {
    return serviceLocator<GlobalFeedObserveUseCase>().listen(request);
  }
}