import 'package:amity_sdk/core/model/api_request/authentication_request.dart';
import 'package:amity_sdk/public/public.dart';

abstract class AuthenticationRepo {
  Future<AmityUser> login(AuthenticationRequest params);
}
