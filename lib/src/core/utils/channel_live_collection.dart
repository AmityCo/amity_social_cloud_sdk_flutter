import 'dart:async';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/utils/amity_nonce.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/usecase/channel/channel_fetch_list_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/channel/channel_observe_list_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/channel/channel_observe_new_item_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class ChannelLiveCollection extends LiveCollection<AmityChannel> {
  RequestBuilder<GetChannelRequest> request;

  ChannelLiveCollection({required this.request});

  @override
  AmityNonce getNonce() {
    return request().getNonce();
  }

  @override
  int getHash() {
    return request().getHashCode();
  }

  @protected
  @override
  Future<PageListData<List<AmityChannel>, String>>
      getFirstPageRequest() async {
    final params = request();
    params.options = OptionsRequest();
    params.options?.token = null;
    params.options?.limit = defaultPageSize;

    return await serviceLocator<ChannelFetchListUseCase>().get(params);
  }

  @protected
  @override
  Future<PageListData<List<AmityChannel>, String>> getNextPageRequestInternal(
      String? token) async {
    final params = request();
    params.options?.token = token;
    params.options?.limit = null;
    return await serviceLocator<ChannelFetchListUseCase>().get(params);
  }

  @override
  StreamController<List<AmityChannel>> getStreamController() {
    return serviceLocator<ChannelObserveListUseCase>().listen(request);
  }

  @protected
  @override
  StreamController<PagingIdHiveEntity> observeNewItem() {
    return serviceLocator<ChannelObserveNewItemUseCase>().listen(request);
  }
}
