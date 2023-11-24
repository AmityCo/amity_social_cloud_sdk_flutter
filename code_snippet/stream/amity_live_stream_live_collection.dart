import 'package:amity_sdk/amity_sdk.dart';
import 'package:flutter/material.dart';

class AmityLiveStreamLiveCollection {
  /* begin_sample_code
    gist_id: a07849368be331aa9e8767af3012c3ef
    filename: AmityLiveStreamLiveCollection.dart
    asc_page: https://docs.amity.co/social/flutter
    description: Flutter live stream live collection example
    */
  late StreamLiveCollection streamLiveCollection;
  List<AmityStream> amityStreams = [];
  final scrollcontroller = ScrollController();

  void observeLiveStream() {
    //initialize Stream live collection
    streamLiveCollection = AmityVideoClient.newStreamRepository()
          .getStreams()
          .isLive(true)
          .status([AmityStreamStatus.live])
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