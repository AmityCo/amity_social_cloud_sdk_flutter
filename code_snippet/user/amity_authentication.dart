import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/session/token/access_token_renewal.dart';
import 'package:flutter/material.dart';

class AmityAuthentication {
  /* begin_sample_code
    gist_id: 4a3d37b5e164655802bdd2c646f9d44a
    filename: AmityAuthentication.dart
    asc_page: https://docs.amity.co/social/flutter
    description: Flutter login example
    */
  void login() async {
    await AmityCoreClient.login('userId', sessionHandler: (AccessTokenRenewal renewal) {
      renewal.renew();
    })
        .displayName('userDisplayName')
        .submit();
  }
  /* end_sample_code */

  /* begin_sample_code
    gist_id: 0ba60532f74959a4188a8a1a2268e91a
    filename: AmityAuthentication.dart
    asc_page: https://docs.amity.co/social/flutter
    description: Flutter observe SessionState
    */
  void observeSessionState() {
    AmityCoreClient.observeSessionState().listen((SessionState sessionState) {
      // Handle SessionState
    });
  }
  /* end_sample_code */

  /* begin_sample_code
    gist_id: 2a8a25426840247bb9d00b15014ed71f
    filename: AmityAuthentication.dart
    asc_page: https://docs.amity.co/social/flutter
    description: Flutter observe SessionState
    */
  void updateSessionUi(SessionState sessionState) {
    if (sessionState == SessionState.NotLoggedIn) {
      // i.e. Show login page
    } else if (sessionState == SessionState.Establishing) {
      // i.e. Show splash screen
    } else if (sessionState == SessionState.Established) {
      // i.e. Show home page
    } else if (sessionState == SessionState.TokenExpired) {
      // i.e. Show splash screen
    } else if (sessionState.isTerminated()) {
      // Show fail to login page
    }
  }
  /* end_sample_code */

  /* begin_sample_code
    gist_id: 0ad700469b2519e2b57a8d04eacc2331
    filename: AmityAuthentication.dart
    asc_page: https://docs.amity.co/social/flutter
    description: Flutter get session handler
    */
  void sessionWillRenewAccessToken(AccessTokenRenewal renewal) {
    renewal.renew();
  }

  Function(AccessTokenRenewal) getSessionHandler()  {
    final sessionHandler = sessionWillRenewAccessToken;
    return sessionHandler;
  }
  /* end_sample_code */

  /* begin_sample_code
    gist_id: 69e662da3d176e089c0fbe3c128b8fb0
    filename: AmityAuthentication.dart
    asc_page: https://docs.amity.co/social/flutter
    description: Flutter renew access token
    */
  Future sessionWithRenewAccessToken(AccessTokenRenewal renewal) async {
    try {
        final myAuthToken = await getAuthTokenFromMyServer();
        renewal.renewWithAuthToken(myAuthToken);
    } catch (error) {
        renewal.unableToRetrieveAuthToken();
    }
  }

  Future<String> getAuthTokenFromMyServer() async {
      // Implement logic on your app
      return Future.value('myAuthToken');
  }
  /* end_sample_code */
}