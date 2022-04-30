import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

class AmityCoreClient {
  static Future setup(
      {required AmityCoreClientOption option,
      bool sycInitialization = false}) async {
    //Reset config get_it instance
    await configServiceLocator.reset(dispose: true);

    //Reset SDK get_it instance
    await serviceLocator.reset(dispose: true);

    configServiceLocator
        .registerLazySingleton<AmityCoreClientOption>(() => option);

    await SdkServiceLocator.initServiceLocator(syc: sycInitialization);

    return;
  }

  static LoginQueryBuilder login(String userId) {
    return LoginQueryBuilder(useCase: serviceLocator(), userId: userId);
  }

  /// Logout will wipe out all the data [AmityCoreClient] holds.
  static Future<void> logout() async {
    //close all the hive boxes and wipe the data
    await serviceLocator<DBClient>().reset();

    //Reload the service locator
    await SdkServiceLocator.reloadServiceLocator();

    return;
  }

  static bool isUserLoggedIn() {
    try {
      getCurrentUser();
      return true;
    } catch (error) {
      return false;
    }
  }

  static String getUserId() {
    return getCurrentUser().userId!;
  }

  static AmityUser getCurrentUser() {
    if (serviceLocator.isRegistered<AmityUser>()) {
      return serviceLocator<AmityUser>();
    }
    throw AmityException(
        message: 'App dont have active user, Please login', code: 401);
  }

  static Future registerDeviceNotification(String fcmToken) {
    return serviceLocator<NotificationRepository>()
        .registerDeviceNotification(fcmToken);
  }

  static Future unregisterDeviceNotification() {
    return serviceLocator<NotificationRepository>()
        .unregisterDeviceNotification();
  }

  static UserRepository newUserRepository() => serviceLocator<UserRepository>();
  static FileRepository newFileRepository() => serviceLocator<FileRepository>();
}

class AmityCoreClientOption {
  final String apiKey;
  final AmityRegionalHttpEndpoint httpEndpoint;
  final AmityRegionalSocketEndpoint socketEndpoint;
  final AmityRegionalMqttEndpoint mqttEndpoint;
  final bool showLogs;

  AmityCoreClientOption({
    required this.apiKey,
    this.httpEndpoint = AmityRegionalHttpEndpoint.SG,
    this.socketEndpoint = AmityRegionalSocketEndpoint.SG,
    this.mqttEndpoint = AmityRegionalMqttEndpoint.SG,
    this.showLogs = false,
  });
}
