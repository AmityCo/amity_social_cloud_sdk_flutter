import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data_source/data_source.dart';
import 'package:amity_sdk/src/domain/domain.dart';

abstract class AuthenticationRepo {
  Future<AmityUser> login(AuthenticationRequest params, {required bool isLegacyVersion});
  Future<AmityUserToken> getUserToken(AuthenticationRequest params, {required bool isLegacyVersion});
  Future renewToken({
    required AccountHiveEntity account,
    String? displayName,
    String? authToken,
    required bool isLegacyVersion,
  });
}
