import 'package:amity_sdk/amity_sdk.dart';

class AmityPostReviewStatusCheck {
  /* begin_sample_code
    gist_id: 4ea0d951cc6a9b2f9edee5a50606984f
    filename: amity_post_status_check.dart
    asc_page: https://docs.amity.co/social/flutter
    description: Flutter query post example
    */

  void checkStatus(AmityPost post) {
    switch (post.feedType) {
      case AmityFeedType.DECLINED:
        // do something
        break;
      case AmityFeedType.PUBLISHED:
        // do something else
        break;

      case AmityFeedType.REVIEWING:
        // do something else
        break;
      
      default:
        break;
    }
  }

  /* end_sample_code */
}
