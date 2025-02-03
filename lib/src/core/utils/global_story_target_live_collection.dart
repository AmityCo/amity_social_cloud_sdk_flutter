import 'dart:async';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/model/api_request/get_global_story_target_request.dart';
import 'package:amity_sdk/src/domain/usecase/story/global_story_targets_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/story/story_target_observe_usercase.dart';
import 'package:flutter/foundation.dart';

class GlobalStoryTargetLiveCollection extends LiveCollection<AmityStoryTarget> {
  AmityGlobalStoryTargetsQueryOption queryOption;

  AmityGlobalStoryTargetsQueryOption queryOptionLocal =
       AmityGlobalStoryTargetsQueryOption.UNSEEN;

  GlobalStoryTargetLiveCollection({required this.queryOption}){
    if (queryOption == AmityGlobalStoryTargetsQueryOption.SMART) {
      queryOptionLocal = AmityGlobalStoryTargetsQueryOption.UNSEEN;
    } else {
      queryOptionLocal =  queryOption;
    }
  }

  @protected
  @override
  Future<PageListData<List<AmityStoryTarget>, String>>
      getFirstPageRequest() async {
    GetGlobalStoryTargetRequest params = GetGlobalStoryTargetRequest();
    if (queryOption == AmityGlobalStoryTargetsQueryOption.SMART) {
      params.isSmartState = true;
      queryOptionLocal = AmityGlobalStoryTargetsQueryOption.UNSEEN;
      params.seenState = queryOptionLocal.value;
    } else {
      params.seenState = queryOption.value;
      queryOptionLocal =  queryOption;
      params.isSmartState = false;
    }

    params.token = null;
    params.limit = 20;
    var pagingData =
        await serviceLocator<GlobalStoryTargetsUsecase>().get(params);

    if (queryOption == AmityGlobalStoryTargetsQueryOption.SMART) {
      if (pagingData.token == 'next') {
        getNextPageRequestInternal(pagingData.token);
      }
    }
    return pagingData;
  }

  @protected
  @override
  Future<PageListData<List<AmityStoryTarget>, String>> getNextPageRequestInternal(
      String? token) async {
    GetGlobalStoryTargetRequest params = GetGlobalStoryTargetRequest();
    if (queryOption == AmityGlobalStoryTargetsQueryOption.SMART) {
      params.isSmartState = true;
      if (token == 'next') {
        queryOptionLocal= AmityGlobalStoryTargetsQueryOption.SEEN;
        params.token = null;
      }

      params.seenState = queryOptionLocal.value;
    } else {
      params.token = token;
      queryOptionLocal =  queryOption;
      params.seenState = queryOption.value;
    }

    params.limit = 20;
    return await serviceLocator<GlobalStoryTargetsUsecase>().get(params);
  }

  @override
  StreamController<List<AmityStoryTarget>> getStreamController() {
    return serviceLocator<StoryTargetObserveUsecase>().listenAll(
        queryOption == AmityGlobalStoryTargetsQueryOption.SMART,
        queryOptionLocal);
  }
}
