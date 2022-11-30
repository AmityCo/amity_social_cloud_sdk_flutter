import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// Message Live Collection
class MessageLiveCollection extends LiveCollection<AmityMessage> {
  /// Message Request Params
  RequestBuilder<MessageQueryRequest> request;

  /// Init [MessageLiveCollection] with message request
  MessageLiveCollection({required this.request});

  @override
  Future<PageListData<List<AmityMessage>, String>> getFirstPageRequest() async {
    final params = request();
    params.options?.token = null;
    return await serviceLocator<MessageQueryUseCase>().get(params);
  }

  @override
  Future<PageListData<List<AmityMessage>, String>> getNextPageRequest(
      String? token) async {
    final params = request();
    params.options?.token = token;
    params.options?.limit = null;
    return await serviceLocator<MessageQueryUseCase>().get(params);
  }

  @override
  StreamController<List<AmityMessage>> getStreamController() {
    return serviceLocator<MessageObserveUsecase>().listen(request);
  }
}
