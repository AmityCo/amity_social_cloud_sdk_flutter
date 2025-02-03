import 'dart:async';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/model/api_request/get_custom_rank_feed_request.dart';
import 'package:amity_sdk/src/domain/usecase/feed/custom_ranking_observe_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/feed/custom_ranking_query_usecase.dart';
import 'package:flutter/foundation.dart';

class CustomRankingLiveCollection extends LiveCollection<AmityPost> {
  RequestBuilder<GetCustomRankFeedRequest> request;

  CustomRankingLiveCollection({required this.request});

  @protected
  @override
  Future<PageListData<List<AmityPost>, String>> getFirstPageRequest() async {
    final params = request();
    params.token = null;
    params.limit = defaultPageSize;
    return await serviceLocator<CustomRankingQueryUsecase>().get(params);
  }

  @protected
  @override
  Future<PageListData<List<AmityPost>, String>> getNextPageRequestInternal(
      String? token) async {
    final params = request();
    params.token = token;
    params.limit = null;
    return await serviceLocator<CustomRankingQueryUsecase>().get(params);
  }

  @override
  StreamController<List<AmityPost>> getStreamController() {
    return serviceLocator<CustomRankingObserveUseCase>().listen(request);
  }
}