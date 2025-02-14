import 'package:amity_sdk/amity_sdk.dart';

class AmityCommunityRealTimeEvent {
  /* begin_sample_code
    gist_id: 1c33c87f1b0c6b4b0216923329b81a0d
    filename: AmityCommunityRealTimeEvent.dart
    asc_page: https://docs.amity.co/social/flutter
    description: Flutter subscribe to community real-time events example
    */
  void subscribePostsAndComments(AmityCommunity amityCommunity) async {
    // ex. subscribing community topic
    await amityCommunity
        .subscription(AmityCommunityEvents.COMMUNITY)
        .subscribeTopic();
    // ex. subscribing posts topic
    await amityCommunity
        .subscription(AmityCommunityEvents.POSTS)
        .subscribeTopic();
    // ex. subscribing comments topic
    await amityCommunity
        .subscription(AmityCommunityEvents.COMMENTS)
        .subscribeTopic();
    // ex. subscribing posts & comments topic
    await amityCommunity
        .subscription(AmityCommunityEvents.POSTS_AND_COMMENTS)
        .subscribeTopic();
    // ex. subscribing stories & comments topic
    await amityCommunity
        .subscription(AmityCommunityEvents.STORIES_AND_COMMENTS)
        .subscribeTopic();
  }
  /* end_sample_code */
}
