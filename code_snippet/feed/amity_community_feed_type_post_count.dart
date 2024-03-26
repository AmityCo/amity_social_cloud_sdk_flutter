import 'package:amity_sdk/amity_sdk.dart';

class AmityCommunityFeedTypePostCount {
  /* begin_sample_code
    gist_id: a8e273f861ab05861fc7d5caf9d32124
    filename: AmityCommunityFeedTypePostCount.dart
    asc_page: https://docs.amity.co/social/flutter
    description:  https://docs.amity.co/social/android/communities#post-count-with-feedtype
    */

  void getPostCountReviewStatus(AmityCommunity community) {
    // possible feed types
    AmityFeedType.PUBLISHED;
    AmityFeedType.DECLINED;
    AmityFeedType.REVIEWING;
    //

    community
        .getPostCount(AmityFeedType.PUBLISHED)
        .then((value) {
          //success
          int postCount = value;
          // Update UI
        })
        .onError((error, stackTrace) {
          // Handle error
        });
  }

  /* end_sample_code */
}
