// ignore_for_file: unused_element

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:uuid/uuid.dart';

/// Token manager to generate the tokemn
class AmityUserTokenManager {
  /// API key for the network
  final String apiKey;

  /// Endpoint for the Evn
  final AmityRegionalHttpEndpoint endpoint;

  /// init Amity Token manager
  AmityUserTokenManager({required this.endpoint, required this.apiKey});

  /// Create Amity JWT toke for the userId
  Future<AmityUserToken> createUserToken(String userId,
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

  /// future function
  void _refreshToken() {}

  /// future function
  void _revokeToken() {}
}
