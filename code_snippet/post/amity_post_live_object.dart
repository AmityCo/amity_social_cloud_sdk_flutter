import 'package:amity_sdk/amity_sdk.dart';
import 'package:flutter/widgets.dart';

class AmityPostGetLiveObject {
  /* begin_sample_code
    gist_id: a2cf948a9f535228003b77a6b8fb0f46
    filename: AmityPostGetLiveObject.dart
    asc_page: https://docs.amity.co/social/flutter
    description: Flutter post live object Example 
    */

  void observePost(String postId) {
    StreamBuilder<AmityPost>(
        stream: AmitySocialClient.newPostRepository().live.getPost(postId),
        builder: (context, snapshot) {
          // update widget
          // eg. widget.text = post.postId
          return Container();
        });
  }

  /* end_sample_code */
}
