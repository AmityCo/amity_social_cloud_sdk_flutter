

import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/public/repo/stream/stream_repository.dart';

class AmityStreamRepositoryInitialization {
  /* begin_sample_code
    gist_id: e12e14f386a7111e91c7bb4078e212b1
    filename: AmityStreamRepositoryInitialization.dart
    asc_page: https://docs.amity.co/social/flutter
    description: Flutter StreamRepository initialization
    */
  void initializeStreamRepository() {
    StreamRepository streamRepository  = AmityVideoClient.newStreamRepository();
  }
  /* end_sample_code */
}
