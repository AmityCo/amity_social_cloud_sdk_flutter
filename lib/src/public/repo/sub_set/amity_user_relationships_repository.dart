import 'package:amity_sdk/src/public/repo/sub_set/amity_my_user_relationship_repository.dart';
import 'package:amity_sdk/src/public/repo/sub_set/amity_user_relationship_repository.dart';

class AmityUserRelationshipsRepository {
  AmityMyUserRelationshipRepository me() {
    return AmityMyUserRelationshipRepository();
  }

  AmityUserRelationshipRepository user(String userId) {
    return AmityUserRelationshipRepository(userId: userId);
  }
}
