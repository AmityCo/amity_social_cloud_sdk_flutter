import 'package:amity_sdk/src/domain/domain.dart';

class GetMyFollowingsLegacyUsecase extends GetMyFollowingsUsecase {
  GetMyFollowingsLegacyUsecase({required super.followRepo, required super.amityFollowRelationshipComposerUsecase});

  @override
  bool getIsLegacy() {
    return true;
  }
}
