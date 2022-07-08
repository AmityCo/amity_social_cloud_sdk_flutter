import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:uuid/uuid.dart';

class AmityUserTokenManager {
  final String apiKey;
  final AmityRegionalHttpEndpoint endpoint;

  AmityUserTokenManager({required this.endpoint, required this.apiKey});

  Future<AmityUserToken> createAuthToken(String userId,
      {String? displayname = '', String? secureToken = ''}) async {
    if ((displayname ?? '').isEmpty) {
      displayname = null;
    }
    if ((secureToken ?? '').isEmpty) {
      secureToken = null;
    } 
    final request = AuthenticationRequest(
        userId: userId,
        displayName: displayname,
        authToken: secureToken,
        deviceId: const Uuid().v1());
    final amityUserToken =
        await serviceLocator<GetUserTokenUsecase>().get(request);
    return amityUserToken;
  }

// future function
  void _refreshToken() {}

// future function
  void _revokeToken() {}
}
