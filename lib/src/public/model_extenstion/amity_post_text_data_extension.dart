import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

extension AmityPostTextDataExtension on TextData {
  AmityTextPostUpdator edit() {
    return AmityTextPostUpdator(useCase: serviceLocator(), targetId: postId);
  }
}
