import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/socket/amity_socket.dart';
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

    configServiceLocator
        .registerLazySingleton<AmityCoreClientOption>(() => option);

    await SdkServiceLocator.initServiceLocator(syc: sycInitialization);

    return;
  }

  /// Login with userId, this will create user session
  static LoginQueryBuilder login(String userId) {
    return LoginQueryBuilder(useCase: serviceLocator(), userId: userId);
  }

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

  //temporarily disconnect chat real-time events from the system,
  //call the function 'login(String userId)' to restore a connection
  static void disconnect() {
    serviceLocator<AmitySocket>().terminate();
  }

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

  ///Register the devie to receive FCM token
  static Future registerDeviceNotification(String fcmToken) {
    return serviceLocator<NotificationRepository>()
        .registerDeviceNotification(fcmToken);
  }

  ///Unregister the device with FCM
  static Future unregisterDeviceNotification() {
    return serviceLocator<NotificationRepository>()
        .unregisterDeviceNotification();
  }

  static AmityPermissionValidator hasPermission(AmityPermission permission) {
    return AmityPermissionValidator(permission);
  }

  /// Create new User Repository
  static UserRepository newUserRepository() => serviceLocator<UserRepository>();

  /// Create new File Repository
  static FileRepository newFileRepository() => serviceLocator<FileRepository>();
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
