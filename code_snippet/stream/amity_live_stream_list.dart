import 'package:amity_sdk/amity_sdk.dart';

class AmityLiveStreamQuery {
  /* begin_sample_code
    gist_id: e4c92d47b09c7d3ed3e4c8c5f59b00df
    filename: AmityLiveStreamQuery.dart
    asc_page: https://docs.amity.co/social/flutter
    description: Flutter query live stream example
    */
  final _amityStream = <AmityStream>[];
  late PagingController<AmityStream> _streamController;

  void queryLiveStream() {
    // Query for Live Stream
    _streamController = PagingController(
      pageFuture: (token) => AmityVideoClient.newStreamRepository()
          .getStreams()
          .isLive(true)
          .status([AmityStreamStatus.live]).getPagingData(
              token: token, limit: 20),
      pageSize: 20,
    )..addListener(
        () {
          if (_streamController.error == null) {
            //handle results, we suggest to clear the previous items
            //and add with the latest _controller.loadedItems
            _amityStream.clear();
            _amityStream.addAll(_streamController.loadedItems);
            //update widgets
          } else {
            //error on pagination controller
            //update widgets
          }
        },
      );
  }
  /* end_sample_code */
}
