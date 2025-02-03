import 'package:amity_sdk/src/data/data.dart';

extension SessionResponseExtension on SessionResponse {
  UserHiveEntity convertToUserHiveEntity() {
    return UserHiveEntity();
  }

  AccountHiveEntity convertToAccountHiveEntity() {
    return AccountHiveEntity()
      ..id = users[0].id
      ..userId = users[0].userId
      ..displayName = users[0].displayName
      ..isActive = users[0].isGlobalBan
      ..accessToken = accessToken
      ..refreshToken = refreshToken
      ..issuedAt = issuedAt
      ..expiresAt = expiresAt;
  }
}
