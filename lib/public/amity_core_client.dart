import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';
import 'package:amity_sdk/public/public.dart';

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
