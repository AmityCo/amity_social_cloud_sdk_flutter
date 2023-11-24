import 'package:amity_sdk/amity_sdk.dart';

class AmityRecordedStreamQuery {
  /* begin_sample_code
    gist_id: 5d14a892499dc2c8418b12723c92d799
    filename: AmityRecordedStreamQuery.dart
    asc_page: https://docs.amity.co/social/flutter
    description: Flutter query recorded stream example
    */
  final _amityStream = <AmityStream>[];
  late PagingController<AmityStream> _streamController;

  void queryRecordedStream() {
    // Query for RecordedStream
    _streamController = PagingController(
      pageFuture: (token) => AmityVideoClient.newStreamRepository()
          .getStreams()
          .status([AmityStreamStatus.recorded])
          .getPagingData(token: token, limit: 20),
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
