import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

///Amity Core Client to do primary Setup
class AmityCoreClient {
  ///Do the intial set
  static Future setup({
    required AmityCoreClientOption option,
    bool sycInitialization = false,
  }) async {
    //Reset config get_it instance
    await configServiceLocator.reset();

    //Reset SDK get_it instance
    await serviceLocator.reset();

    configServiceLocator.registerLazySingleton<AmityCoreClientOption>(() => option);

    await SdkServiceLocator.initServiceLocator(syc: sycInitialization);

    _intialCleanUp();

    return;
  }

  /* begin_public_function 
  id: client.login
  api_style: async
  */
  /// Login with userId, this will create user session
  static LoginQueryBuilder login(String userId) {
    return LoginQueryBuilder(useCase: serviceLocator(), userId: userId);
  }
  /* end_public_function */

  /* begin_public_function 
  id: client.logout
  */
  /// Logout will wipe out all the data [AmityCoreClient] holds.
  static Future<void> logout() async {
    //terminate current activeSocket
    serviceLocator<AmitySocket>().terminate();
    //close all the hive boxes and wipe the data
    await serviceLocator<DBClient>().reset();

    //Reload the service locator
    await SdkServiceLocator.reloadServiceLocator();

    return;
  }
  /* end_public_function */

  /* begin_public_function 
  id: client.disconnect
  */
  ///temporarily disconnect chat real-time events from the system,
  //call the function 'login(String userId)' to restore a connection
  static void disconnect() {
    serviceLocator<AmitySocket>().terminate();
  }
  /* end_public_function */

  ///Check if user is logged in
  static bool isUserLoggedIn() {
    try {
      getCurrentUser();
      return true;
    } catch (error) {
      return false;
    }
  }

  ///Get logged in user id
  ///if user is not logged in this method will Through [AmityException]
  static String getUserId() {
    return getCurrentUser().userId!;
  }

  /* begin_public_function 
  id: client.get_current_user
  */
  ///Get logged in user
  ///if user is not logged in this method will Through [AmityException]
  static AmityUser getCurrentUser() {
    if (serviceLocator.isRegistered<AmityUser>()) {
      return serviceLocator<AmityUser>();
    }
    throw AmityException(
      message: 'App dont have active user, Please login',
      code: 401,
    );
  }
  /* end_public_function */

  /* begin_public_function 
  id: client.update_user
  api_style: async
  */
  /// API to update the user
  UserUpdateQueryBuilder updateUser() {
    return UserUpdateQueryBuilder(serviceLocator<UpdateUserUsecase>(), getUserId());
  }
  /* end_public_function */

  /* begin_public_function 
  id: client.register_push
  */
  ///Register the devie to receive FCM token
  static Future registerDeviceNotification(String fcmToken) {
    return serviceLocator<NotificationRepository>().registerDeviceNotification(fcmToken);
  }
  /* end_public_function */

  /* begin_public_function 
  id: client.unregister_push
  */
  ///Unregister the device with FCM
  static Future unregisterDeviceNotification() {
    return serviceLocator<NotificationRepository>().unregisterDeviceNotification();
  }
  /* end_public_function */

  /// Check if Current user have the permissions
  static AmityPermissionValidator hasPermission(AmityPermission permission) {
    return AmityPermissionValidator(permission);
  }

  /// Create new User Repository
  static UserRepository newUserRepository() => serviceLocator<UserRepository>();

  /// Create new File Repository
  static AmityFileRepository newFileRepository() => serviceLocator<AmityFileRepository>();

  /// Intial Clean for SDK
  static _intialCleanUp() {
    // Remove all the Syncing State Message (Unsend messages)
    serviceLocator<MessageDbAdapter>().getUnsendMessages().forEach((element) => element.delete());
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
}
