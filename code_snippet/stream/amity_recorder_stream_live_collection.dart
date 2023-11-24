import 'package:amity_sdk/amity_sdk.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AmityRecordedStreamLiveCollection {
  /* begin_sample_code
    gist_id: 304addb4a4ff1e45b2792ac4d26d2868
    filename: AmityRecordedStreamLiveCollection.dart
    asc_page: https://docs.amity.co/social/flutter
    description: Flutter recorded stream live collection example
    */
  late StreamLiveCollection streamLiveCollection;
  List<AmityStream> amityStreams = [];
  final scrollcontroller = ScrollController();

  void observeRecordedStream(String channelId) {
    //initialize recorded stream live collection
    streamLiveCollection = AmityVideoClient.newStreamRepository()
          .getStreams()
          .status([AmityStreamStatus.recorded])
          .getLiveCollection(pageSize: 20);

    //listen to data changes from live collection
    streamLiveCollection.getStreamController().stream.listen((event) {
      // update latest results here
      // setState(() {
      amityStreams = event;
      // });
    });

    //load first page when initiating widget
    streamLiveCollection.loadNext();

    //add pagination listener when srolling to top/bottom
    scrollcontroller.addListener(paginationListener);
  }

  void paginationListener() {
    //check if
    //#1 scrolling reached top/bottom
    //#2 live collection has next page to load more
    if ((scrollcontroller.position.pixels ==
            (scrollcontroller.position.maxScrollExtent)) &&
        streamLiveCollection.hasNextPage()) {
      streamLiveCollection.loadNext();
    }
  }
  /* end_sample_code */
}