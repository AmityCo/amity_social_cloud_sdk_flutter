import 'package:amity_sdk/public/repo/amity_my_user_relationship_repository.dart';
import 'package:amity_sdk/public/repo/amity_user_relationship_repository.dart';

class AmityUserRelationshipsRepository {
  AmityMyUserRelationshipRepository me() {
    return AmityMyUserRelationshipRepository();
  }

  AmityUserRelationshipRepository user(String userId) {
    return AmityUserRelationshipRepository(userId: userId);
  }
}
