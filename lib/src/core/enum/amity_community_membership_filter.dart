// ignore_for_file: constant_identifier_names

import 'package:amity_sdk/src/core/enum/enum.dart';

enum AmityCommunityMembershipFilter { ALL, MEMBER, BANNED }

extension AmityCommnunityMembershipFilterExtension
    on AmityCommunityMembershipFilter {
  String get apiKey {
    return [
      'all',
      'memmber',
      'banned',
    ][index];
  }

  List<String> get memberships {
    return [
      [AmityMembershipType.MEMBER.value, AmityMembershipType.BANNED.value],
      [AmityMembershipType.MEMBER.value],
      [AmityMembershipType.BANNED.value]
    ][index];
  }
}
