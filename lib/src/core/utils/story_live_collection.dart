import 'dart:async';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/usecase/story/get_stories_by_target_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/story/story_observe_usecase.dart';


class StoryLiveCollection extends LiveCollectionWithoutPagination<AmityStory>{

   RequestBuilder<GetStoriesByTragetRequest> request;

  StoryLiveCollection({required this.request});

  @override
  Future<List<AmityStory>> getData() async {
    return await serviceLocator<GetStoryByTargetUseCase>().get(request());
  }

  @override
  StreamController<List<AmityStory>> getStreamController() {
    return serviceLocator<StoryObserveUseCase>().listen(request);
  }



}