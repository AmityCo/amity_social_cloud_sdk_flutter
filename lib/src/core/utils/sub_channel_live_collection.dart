import 'dart:async';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/model/api_request/get_sub_channels_request.dart';
import 'package:amity_sdk/src/domain/usecase/subchannel/sub_channel_get_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/subchannel/sub_channel_obsever_usecase.dart';
import 'package:flutter/foundation.dart';

class SubChannelLiveCollection extends LiveCollection<AmitySubChannel> {
  
  RequestBuilder<GetSubChannelsRequest> request;
  SubChannelLiveCollection({required this.request});

  @protected
  @override
  Future<PageListData<List<AmitySubChannel>, String>> getFirstPageRequest() async {
    final params = request();
    params.options?.token = null;
    return await serviceLocator<SubChannelGetUsecase>().get(params);
  }

  @protected
  @override
  Future<PageListData<List<AmitySubChannel>, String>> getNextPageRequestInternal(String? token) async {
    final params = request();
    params.options?.token = token;
    params.options?.limit = null;
    return await serviceLocator<SubChannelGetUsecase>().get(params);
  }

  @override
  StreamController<List<AmitySubChannel>> getStreamController() {
    return serviceLocator<SubChannelObserverUseCase>().listen(request);
  }

}