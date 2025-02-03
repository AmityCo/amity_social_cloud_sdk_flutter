import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data_source/data_source.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/usecase/message/message_fetch_use_case.dart';
import 'package:amity_sdk/src/domain/usecase/message/message_observe_list_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/message/message_observe_new_item_usecase.dart';
import 'package:flutter/foundation.dart';

/// Message Live Collection
class MessageLiveCollection extends LiveCollection<AmityMessage> {
  /// Message Request Params
  RequestBuilder<MessageQueryRequest> request;

  /// Init [MessageLiveCollection] with message request
  MessageLiveCollection({required this.request});

  @protected
  @override
  Future<PageListData<List<AmityMessage>, String>> getFirstPageRequest() async {
    final params = request();
    params.options?.token = null;
    params.options?.limit = defaultPageSize;
    return await serviceLocator<MessageFetchUseCase>().get(params);
  }

  @protected
  @override
  Future<PageListData<List<AmityMessage>, String>> getNextPageRequestInternal(
      String? token) async {
    final params = request();
    params.options?.token = token;
    params.options?.limit = null;
    return await serviceLocator<MessageFetchUseCase>().get(params);
  }

  @override
  StreamController<List<AmityMessage>> getStreamController() {
    return serviceLocator<MessageObserveListUseCase>().listen(request);
  }

  @protected
  @override
  StreamController<PagingIdHiveEntity> observeNewItem() {
    return serviceLocator<MessageObserveNewItemUseCase>().listen(request);
  }
}
