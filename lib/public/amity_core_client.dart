import 'package:amity_sdk/lib.dart';
import 'package:amity_sdk/public/repo/notification_repository.dart';

class AmityCoreClient {
  static Future setup(
      {required AmityCoreClientOption option,
      bool sycInitialization = false}) async {
    // if (serviceLocator.isRegistered<AmityCoreClientOption>()) {
    //   serviceLocator.unregister<AmityCoreClientOption>();
    // }
    await serviceLocator.reset(dispose: true);
    serviceLocator.registerLazySingleton<AmityCoreClientOption>(() => option);

    final voidFuture =
        await SdkServiceLocator.initServiceLocator(syc: sycInitialization);
    return voidFuture;
  }

  static LoginQueryBuilder login(String userId) {
    return LoginQueryBuilder(useCase: serviceLocator(), userId: userId);
  }

  /// Logout will wipe out all the data [AmityCoreClient] holds.
  static Future<void> logout() async {
    //Delete the db data
    await serviceLocator<DBClient>().reset();

    //reset all the in memory dependencies
    await serviceLocator.reset(dispose: true);

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
