import 'package:amity_sdk/core/model/api_request/authentication_request.dart';
import 'package:amity_sdk/data/response/session_response.dart';

abstract class AuthenticationApiInterface {
  Future<SessionResponse> login(AuthenticationRequest request);
}
