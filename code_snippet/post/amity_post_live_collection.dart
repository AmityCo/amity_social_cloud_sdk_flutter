import 'package:amity_sdk/amity_sdk.dart';
import 'package:flutter/material.dart';

class AmityPostLiveCollection {
  /* begin_sample_code
    gist_id: 264bdc25880fcf6a9173d558f3d38af9
    filename: AmityPostLiveCollection.dart
    asc_page: https://docs.amity.co/social/flutter
    description: Flutter post live collection example
    */
  late PostLiveCollection postLiveCollection;
  List<AmityPost> amityPosts = [];
  final scrollcontroller = ScrollController();

  void observePosts(String userId) {
    //initialize post live collection
    postLiveCollection = AmitySocialClient.newPostRepository()
        .getPosts()
        .targetUser(userId)
        .getLiveCollection(pageSize: 20);

    //listen to data changes from live collection
    postLiveCollection.getStreamController().stream.listen((event) {
      // update latest results here
      // setState(() {
      amityPosts = event;
      // });
    });

    //load first page when initiating widget
    postLiveCollection.loadNext();

    //add pagination listener when srolling to top/bottom
    scrollcontroller.addListener(paginationListener);
  }

  void paginationListener() {
    //check if
    //#1 scrolling reached top/bottom
    //#2 live collection has next page to load more
    if ((scrollcontroller.position.pixels ==
            (scrollcontroller.position.maxScrollExtent)) &&
        postLiveCollection.hasNextPage()) {
      postLiveCollection.loadNext();
    }
  }
  /* end_sample_code */
}
