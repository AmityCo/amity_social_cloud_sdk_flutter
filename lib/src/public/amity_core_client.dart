import 'dart:ui';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/core_client.dart';
import 'package:amity_sdk/src/core/engine/analytics_engine.dart';
import 'package:amity_sdk/src/core/session/token/access_token_renewal.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/usecase/network/validate_text_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/network/validate_urls_usecase.dart';
import 'package:amity_sdk/src/public/public.dart';
import 'package:amity_sdk/src/public/repo/ads/amity_ad_repository.dart';
import 'package:amity_sdk_api/stream/amity_client_configuration.dart';

///Amity Core Client to do primary Setup
class AmityCoreClient extends CoreClient {

  ///Do the intial set
  static Future setup({
    required AmityCoreClientOption option,
    bool sycInitialization = false,
  }) async {
    await CoreClient.setup(option: option, sycInitialization: sycInitialization);
    return;
  }

  /* begin_public_function
  id: client.login
  api_style: async
  */
  /// Login with userId, this will create user session
  static LoginQueryBuilder login(String userId, {Function(AccessTokenRenewal)? sessionHandler}) {
    return CoreClient.login(userId, sessionHandler: sessionHandler);
  }
  /* end_public_function */

  /* begin_public_function
  id: client.logout
  */
  /// Logout will wipe out all the data [AmityCoreClient] holds.
  static Future<void> logout() async {
    CoreClient.logout();
    return;
  }
  /* end_public_function */

  Future<bool> validateUrls(List<String> urls)  async  {
      return await  ValidateUrlsUseCase(networkSettingsRepo: serviceLocator()).get(urls);
  }

  Future<bool> validateTexts( List<String> texts) async  {
      return await  ValidateTextsUseCase(networkSettingsRepo: serviceLocator()).get(texts);
  }

  /* begin_public_function
  id: client.disconnect
  */
  ///temporarily disconnect chat real-time events from the system,
  //call the function 'login(String userId)' to restore a connection
  static void disconnect() {
    CoreClient.disconnect();
  }
  /* end_public_function */

  ///Check if user is logged in
  static bool isUserLoggedIn(){
    return CoreClient.isUserLoggedIn();
  }

  ///Get logged in user id
  ///if user is not logged in this method will Through [AmityException]
  static String getUserId() {
    return CoreClient.getUserId();
  }

  /* begin_public_function
  id: client.get_current_user
  */
  ///Get logged in user
  ///if user is not logged in this method will Through [AmityException]
  static AmityUser getCurrentUser() {
    return CoreClient.getCurrentUser();
  }
  /* end_public_function */

  /* begin_public_function
  id: client.get_configuration
  */
  static AmityClientConfiguration getConfiguration() {
    return CoreClient.getConfiguration();
  }
  /* end_public_function */

  /* begin_public_function
  id: client.update_user
  api_style: async
  */
  /// API to update the user
  static UserUpdateQueryBuilder updateUser() {
    return CoreClient.updateUser();
  }
  /* end_public_function */

  /* begin_public_function
  id: client.register_push
  */
  ///Register the devie to receive FCM token
  static Future registerDeviceNotification(String fcmToken) {
    return CoreClient.registerDeviceNotification(fcmToken);
  }
  /* end_public_function */

  /* begin_public_function
  id: client.unregister_push
  */
  ///Unregister the device with FCM
  static Future unregisterDeviceNotification() {
    return CoreClient.unregisterDeviceNotification();
  }
  /* end_public_function */


  /* begin_public_function
	  id: client.notifications
	*/
  AmityNotification notifications()  {
        return CoreClient.notifications();
    }
    /* end_public_function */

  /// Check if Current user have the permissions
  static AmityPermissionValidator hasPermission(AmityPermission permission) {
    return CoreClient.hasPermission(permission);
  }

  /// Create new User Repository
  static UserRepository newUserRepository() => serviceLocator<UserRepository>();

  /// Create new Ad Repository
  static AmityAdRepository newAdRepository() =>
      serviceLocator<AmityAdRepository>();

  /// Create new File Repository
  static AmityFileRepository newFileRepository() =>
      serviceLocator<AmityFileRepository>();

  static AnalyticsEngine? getAnalyticsEngine() {
    return CoreClient.analyticsEngine;
  }

  static Stream<SessionState> observeSessionState() {
    return CoreClient.observeSessionState();
  }

}

/// This class is AmityCore option to do initial setup Amity
class AmityCoreClientOption {
  /// network Apikey
  final String apiKey;

  /// Http endpoint for amity client
  final AmityRegionalHttpEndpoint httpEndpoint;

  /// Socket endpoint for amity client
  final AmityRegionalSocketEndpoint socketEndpoint;

  /// MQTT endpoint for amity client
  final AmityRegionalMqttEndpoint mqttEndpoint;

  /// flag to show logs for debug, by default it false
  final bool showLogs;

  /// Amity Core Client Options to do initial Amity Client
  AmityCoreClientOption({
    required this.apiKey,
    this.httpEndpoint = AmityRegionalHttpEndpoint.SG,
    this.socketEndpoint = AmityRegionalSocketEndpoint.SG,
    this.mqttEndpoint = AmityRegionalMqttEndpoint.SG,
    this.showLogs = false,
  });

  AmityCoreClientOption copyWith({
    String? apiKey,
    AmityRegionalHttpEndpoint? httpEndpoint,
    AmityRegionalSocketEndpoint? socketEndpoint,
    AmityRegionalMqttEndpoint? mqttEndpoint,
    bool? showLogs,
  }) {
    return AmityCoreClientOption(
      apiKey: apiKey ?? this.apiKey,
      httpEndpoint: httpEndpoint ?? this.httpEndpoint,
      socketEndpoint: socketEndpoint ?? this.socketEndpoint,
      mqttEndpoint: mqttEndpoint ?? this.mqttEndpoint,
      showLogs: showLogs ?? this.showLogs,
    );
  }
}
