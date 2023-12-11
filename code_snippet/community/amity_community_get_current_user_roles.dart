import 'package:amity_sdk/amity_sdk.dart';

class AmityCommunityGetCurrentUserRoles {
  /* begin_sample_code
    gist_id: 9be6b82f2b136485e4aea267aeb7ea4a
    filename: AmityCommunityGetCurrentUserRoles.dart
    asc_page: https://docs.amity.co/social/flutter
    description: Flutter Get Current User Community Roles example
    */
  void getCurrentUserRole(String communityId) async {
    List<String>? currentUserRoles =
        await AmitySocialClient.newCommunityRepository()
            .getCurrentUserRoles(communityId);
    if (currentUserRoles == null) {
      // Not a memeber
    } else {
      if (currentUserRoles.isEmpty) {
        // just a Member
      } else {
        // Have Roles (eg. Mod)
      }
    }
  }
  /* end_sample_code */
}
