import 'package:amity_sdk/src/domain/domain.dart';

class GetMyFollowersLegacyUsecase extends GetMyFollowersUsecase {
  GetMyFollowersLegacyUsecase({required super.followRepo, required super.amityFollowRelationshipComposerUsecase});

  @override
  bool getIsLegacy() {
    return true;
  }
}
