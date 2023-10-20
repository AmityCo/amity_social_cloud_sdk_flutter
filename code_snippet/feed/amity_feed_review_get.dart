import 'package:amity_sdk/amity_sdk.dart';

class AmityFeedReviewGet{
  /* begin_sample_code
    gist_id: e54de90487f43a2c83eb041b3c8a4e52
    filename: amity_fee_review.dart
    asc_page: https://docs.amity.co/social/flutter
    description: Flutter query post example
    */
  final amityPosts = <AmityPost>[];
  late PagingController<AmityPost> _controller;

  //User's Media Gallery Example
  //For this use-case:
  //  - Get all the post from a community based onn feedType
  void initPagingController(String communityId) {
    //inititate the PagingController
    _controller = PagingController(
      pageFuture: (token) => AmitySocialClient.newPostRepository()
          .getPosts()
          .targetCommunity(communityId)
          //feedType could be AmityFeedType.PUBLISHED, AmityFeedType.REVIEWING, AmityFeedType.DECLINED
          .feedType(AmityFeedType.REVIEWING)
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
    _controller.fetchNextPage()
        //optional
        .then((value) {
      //success
    });
  }
  /* end_sample_code */
}