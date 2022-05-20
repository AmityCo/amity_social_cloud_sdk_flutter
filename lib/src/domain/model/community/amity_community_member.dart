import 'package:amity_sdk/src/domain/model/amity_premissions.dart';
import 'package:amity_sdk/src/domain/model/amity_roles.dart';
import 'package:amity_sdk/src/domain/model/amity_user.dart';
import 'package:flutter/foundation.dart';

class AmityCommunityMember extends ChangeNotifier implements ValueListenable<AmityCommunityMember> {
  String? communityId;
  String? userId;
  String? channelId;
  // bool? isBanned;
  AmityRoles? roles;
  AmityPermissions? permissions;
  AmityUser? user;

  @override
  AmityCommunityMember get value => this;
}
