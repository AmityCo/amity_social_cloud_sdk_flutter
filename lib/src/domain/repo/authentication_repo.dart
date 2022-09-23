import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

abstract class AuthenticationRepo {
  Future<AmityUser> login(AuthenticationRequest params);
  Future<AmityUserToken> getUserToken(AuthenticationRequest params);
}
