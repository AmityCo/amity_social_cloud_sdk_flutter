import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/model/amity_user_token.dart';

abstract class AuthenticationRepo {
  Future<AmityUser> login(AuthenticationRequest params);
  Future<AmityUserToken> getUserToken(AuthenticationRequest params);
}
