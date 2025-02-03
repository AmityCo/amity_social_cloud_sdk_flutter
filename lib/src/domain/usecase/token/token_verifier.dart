// token_verifier.dart
import 'package:amity_sdk/src/core/core_client.dart';
import 'package:amity_sdk/src/data/data.dart';

class TokenVerifier {
  static TokenVerifierResult checkExpiration(AccountHiveEntity account) {
    final now = CoreClient.getServerTime();
    final expiresAt = account.expiresAt;
    final aboutToExpireAt = account.aboutToExpireAt;
    if (expiresAt != null && now.isAfter(expiresAt)) {
      return TokenVerifierResult.expired;
    } else if (expiresAt != null &&
        aboutToExpireAt != null &&
        now.isBefore(expiresAt) &&
        now.isAfter(aboutToExpireAt)) {
      return TokenVerifierResult.aboutToExpire;
    } else {
      return TokenVerifierResult.valid;
    }
  }
}

enum TokenVerifierResult {
  valid,
  aboutToExpire,
  expired,
}
