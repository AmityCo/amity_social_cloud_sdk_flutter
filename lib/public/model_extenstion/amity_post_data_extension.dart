import 'package:amity_sdk/lib.dart';

extension AmityPostDataExtension on AmityPostData {
  AmityTextPostUpdator edit() {
    return AmityTextPostUpdator(useCase: serviceLocator(), targetId: postId);
  }
}
