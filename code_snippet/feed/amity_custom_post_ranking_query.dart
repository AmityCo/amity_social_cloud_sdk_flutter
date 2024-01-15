import 'package:amity_sdk/amity_sdk.dart';

class AmityCustomRankingGlobalFeed {
  /* begin_sample_code
    gist_id: a0710374320b17096c269e4e5e953843
    filename: AmityCustomRankingGlobalFeed.dart
    asc_page: https://docs.amity.co/social/flutter
    description: Flutter Custom Post Ranking example
    */
  final amityPosts = <AmityPost>[];
  late PagingController<AmityPost> _controller;

  void initPagingController() {
    //inititate the PagingController
    _controller = PagingController(
      pageFuture: (token) => AmitySocialClient.newFeedRepository()
          .getCustomRankingGlobalFeed()
          .getPagingData(token: token, limit: 20),
      pageSize: 20,
    )..addListener(
        () {
          if (_controller.error == null) {
            //handle results, we suggest to clear the previous items
            //and add with the latest _controller.loadedItems
            amityPosts.clear();
            amityPosts.addAll(_controller.loadedItems);
            //update widgets
          } else {
            //error on pagination controller
            //update widgets
          }
        },
      );
  }

//when the ListView widget is reached the bottom of the
//page, you need to trigger next page by calling
//_controller.fetchNextPage()
  void loadMore() {
    _controller
        .fetchNextPage()
        //optional
        .then((value) {
      //success
    });
  }

  /* end_sample_code */
}
