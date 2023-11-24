import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/model/api_request/stream_query_request.dart';
import 'package:amity_sdk/src/domain/model/amity_stream/amity_stream.dart';
import 'package:amity_sdk/src/domain/usecase/stream/stream_observe_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/stream/stream_qurey_usecase.dart';

class StreamLiveCollection extends LiveCollection<AmityStream>{

  RequestBuilder<StreamQueryRequest> request;

  StreamLiveCollection({required this.request});

  @override
  Future<PageListData<List<AmityStream>, String>> getFirstPageRequest() async {
    final params = request();
    params.options?.token = null;
    return await serviceLocator<StreamQueryUseCase>().get(params);
  }

  @override
  Future<PageListData<List<AmityStream>, String>> getNextPageRequest(String? token)async {
    final params = request();
    params.options?.token = token;
    params.options?.limit = null;
    return await serviceLocator<StreamQueryUseCase>().get(params);
  }

  @override
  StreamController<List<AmityStream>> getStreamController() {
    return serviceLocator<StreamObserveUseCase>().listen(request);
  }

  
}