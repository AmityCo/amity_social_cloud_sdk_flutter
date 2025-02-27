import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class GetUserFollowingsLegacyUsecase extends GetUserFollowingsUsecase {
  GetUserFollowingsLegacyUsecase({required super.followRepo, required super.amityFollowRelationshipComposerUsecase});

  @override
  bool getIsLegacy() {
    return true;
  }
}
