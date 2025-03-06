import 'package:amity_sdk/src/domain/domain.dart';

class GetUserFollowersLegacyUsecase extends GetUserFollowersUsecase {
  GetUserFollowersLegacyUsecase({required super.followRepo, required super.amityFollowRelationshipComposerUsecase});

  @override
  bool getIsLegacy() {
    return true;
  }
}
