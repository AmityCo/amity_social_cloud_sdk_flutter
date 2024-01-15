import 'dart:async';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/usecase/post/post_observe_usecase.dart';

class PostLiveCollection extends LiveCollection<AmityPost> {
  RequestBuilder<GetPostRequest> request;

  PostLiveCollection({required this.request});

  @override
  Future<PageListData<List<AmityPost>, String>> getFirstPageRequest() async {
    final params = request();
    params.options?.token = null;
    return await serviceLocator<PostGetUsecase>().get(params);
  }

  @override
  Future<PageListData<List<AmityPost>, String>> getNextPageRequest(
      String? token) async {
    final params = request();
    params.options?.token = token;
    params.options?.limit = null;
    return await serviceLocator<PostGetUsecase>().get(params);
  }

  @override
  StreamController<List<AmityPost>> getStreamController() {
    return serviceLocator<PostObserveUseCase>().listen(request);
  }
}