import 'package:amity_sdk/lib.dart';

extension AmityPostTextDataExtension on TextData {
  AmityTextPostUpdator edit() {
    return AmityTextPostUpdator(useCase: serviceLocator(), targetId: postId);
  }
}
