import 'package:amity_sdk/src/public/public.dart';

class AmityUserRelationshipsRepository {
  AmityMyUserRelationshipRepository me() {
    return AmityMyUserRelationshipRepository();
  }

  AmityUserRelationshipRepository user(String userId) {
    return AmityUserRelationshipRepository(userId: userId);
  }
}
