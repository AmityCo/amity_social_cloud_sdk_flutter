import 'package:amity_sdk/amity_sdk.dart';

class AmityStoryGetRepository {
  /* begin_sample_code
    gist_id: a771269a678cfd77e67279ba9ecf3e57
    filename: AmityStoryGetRepository.dart
    asc_page: https://docs.amity.co/social/flutter
    description: Flutter get Story repository example
    */

  void initStoryRepository() {
    AmityStoryRepository storyRepository = AmitySocialClient.newStoryRepository();
  }
  /* end_sample_code */
}