import 'package:amity_sdk/amity_sdk.dart';

class AmityStreamById {
  /* begin_sample_code
    gist_id: b7f2b94499697b80e1908409faefc44f
    filename: AmityStreamById.dart
    asc_page: https://docs.amity.co/social/flutter
    description: Flutter get Stream by id
    */
  AmityStream? _amityStream;

  void getAmityStreamById(String streamId) {
    AmityVideoClient.newStreamRepository()
        .getStream(streamId)
        .then((value) => _amityStream = value);
  }
  /* end_sample_code */
}
