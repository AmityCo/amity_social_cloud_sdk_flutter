import 'package:amity_sdk/amity_sdk.dart';

class AmityStoryGetActiveStories {
  /* begin_sample_code
    gist_id: 125f974cf91a79430b33bdb0bb513288
    filename: AmityStoryGetActiveStories.dart
    asc_page: https://docs.amity.co/social/flutter
    description: Flutter get active stories example
    */

  late StoryLiveCollection storyLiveCollection;
  List<AmityStory> amityStories = [];

  void observeStories(AmityStoryTargetType targetType, String targetId) {
    storyLiveCollection = StoryLiveCollection(
        request: () => AmitySocialClient.newStoryRepository()
            .getActiveStories(targetId: targetId, targetType: targetType)
            .build());

    storyLiveCollection.getStreamController().stream.listen((event) {
      // update latest results here
      // setState(() {
      amityStories = event;
      // });
    });

    storyLiveCollection.getData();
    
  }
  /* end_sample_code */
}
