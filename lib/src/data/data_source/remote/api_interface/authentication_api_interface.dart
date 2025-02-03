import 'package:amity_sdk/src/core/model/api_request/authentication_request.dart';
import 'package:amity_sdk/src/data/response/session_response.dart';

abstract class AuthenticationApiInterface {
  Future<SessionResponse> login(AuthenticationRequest request, { bool isLegacyVersion = true });
  Future<SessionResponse> refreshToken(String userId, String refreshToken);
  Future verifyAccessToken();
}
