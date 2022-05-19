import 'package:amity_sdk/src/domain/model/amity_premissions.dart';
import 'package:amity_sdk/src/domain/model/amity_roles.dart';
import 'package:amity_sdk/src/domain/model/amity_user.dart';

class AmityCommunityMember {
  String? communityId;
  String? userId;
  String? channelId;
  // bool? isBanned;
  AmityRoles? roles;
  AmityPermissions? permissions;
  AmityUser? user;
}
