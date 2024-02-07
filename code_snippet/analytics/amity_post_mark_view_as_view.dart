import 'package:amity_sdk/amity_sdk.dart';

class AmityMarkPostAsViewed {
  /* begin_sample_code
    gist_id: 1a5bc855b84b8ad9070b1f331ed37ea0
    filename: AmityMarkPostAsViewed.dart
    asc_page: https://docs.amity.co/social/flutter
    description: Flutter mark post as viewed example
    */
  void markPostAsViewed(AmityPost post) {
    // To mark post as viewed
    post.analytics().markPostAsViewed();
    // To get Impressions
    post.impression;
    // To get Reach
    post.reach;
  }
  /* end_sample_code */
}
