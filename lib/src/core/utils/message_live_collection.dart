import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// Message Live Collection
class MessageLiveCollection extends LiveCollection<AmityMessage> {
  /// Message Request Params
  MessageQueryRequest params;

  /// Init [MessageLiveCollection] with message request
  MessageLiveCollection({required this.params});

  @override
  Future<PageListData<List<AmityMessage>, String>> getFirstPageRequest() async {
    params.options?.token = null;
    return await serviceLocator<MessageQueryUseCase>().get(params);
  }

  @override
  Future<PageListData<List<AmityMessage>, String>> getNextPageRequest(
      String? token) async {
    params.options?.token = token;
    params.options?.limit = null;
    return await serviceLocator<MessageQueryUseCase>().get(params);
  }

  @override
  StreamController<List<AmityMessage>> asStream() {
    return serviceLocator<MessageObserveUsecase>().listen(params);
  }
}
