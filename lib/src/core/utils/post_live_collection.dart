import 'dart:async';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/usecase/post/post_observe_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/post/post_query_usecase.dart';
import 'package:flutter/foundation.dart';

class PostLiveCollection extends LiveCollection<AmityPost> {
  RequestBuilder<GetPostRequest> request;

  PostLiveCollection({required this.request});

  @protected
  @override
  Future<PageListData<List<AmityPost>, String>> getFirstPageRequest() async {
    final params = request();
    params.options?.token = null;
    params.options?.limit = defaultPageSize;
    return await serviceLocator<PostQueryUsecase>().get(params);
  }

  @protected
  @override
  Future<PageListData<List<AmityPost>, String>> getNextPageRequestInternal(
      String? token) async {
    final params = request();
    params.options?.token = token;
    params.options?.limit = null;
    return await serviceLocator<PostQueryUsecase>().get(params);
  }

  @override
  StreamController<List<AmityPost>> getStreamController() {
    return serviceLocator<PostObserveUseCase>().listen(request);
  }
}