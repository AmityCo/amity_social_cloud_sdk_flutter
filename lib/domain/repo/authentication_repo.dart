import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';

abstract class AuthenticationRepo {
  Future<AmityUser> login(AuthenticationRequest params);
}
