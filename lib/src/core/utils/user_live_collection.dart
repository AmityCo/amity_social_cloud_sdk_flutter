import 'dart:async';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/utils/amity_nonce.dart';
import 'package:amity_sdk/src/domain/usecase/user/user_fetch_list_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/user/user_observe_list_usecase.dart';
import 'package:flutter/foundation.dart';

class UserLiveCollection extends LiveCollection<AmityUser> {
  RequestBuilder<UsersRequest> request;

  UserLiveCollection({required this.request});

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
  Future<PageListData<List<AmityUser>, String>>
      getFirstPageRequest() async {
    final params = request();
    params.options = OptionsRequest();
    params.options?.token = null;
    params.options?.limit = defaultPageSize;

    return await serviceLocator<UserFetchListUseCase>().get(params);
  }

  @protected
  @override
  Future<PageListData<List<AmityUser>, String>> getNextPageRequestInternal(
      String? token) async {
    final params = request();
    params.options?.token = token;
    params.options?.limit = null;
    return await serviceLocator<UserFetchListUseCase>().get(params);
  }

  @override
  StreamController<List<AmityUser>> getStreamController() {
    return serviceLocator<UserObserveListUseCase>().listen(request);
  }
}
