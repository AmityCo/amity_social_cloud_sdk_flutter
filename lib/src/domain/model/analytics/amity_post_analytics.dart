import 'package:amity_sdk/src/domain/usecase/analytics/mark_post_as_viewed_usecase.dart';

class AmityPostAnalytics {
  String postId;
  AmityPostAnalytics(this.postId);
  void markPostAsViewed() {
    MarkPostAsViewedUseCase().get(postId);
  }
}
