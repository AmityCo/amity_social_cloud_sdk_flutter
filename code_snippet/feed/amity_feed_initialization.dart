import 'package:amity_sdk/amity_sdk.dart';

class AmityFeedRepository {
  /* begin_sample_code
    gist_id: 248beca2d42eedb79aabb2591d834657
    filename: AmityFeedRepository.dart
    asc_page: https://docs.amity.co/social/flutter
    description: Flutter get post example
    */
  

  void initializeFeedRepository() {
    FeedRepository feedRepository = AmitySocialClient.newFeedRepository();
  }
  /* end_sample_code */
}
