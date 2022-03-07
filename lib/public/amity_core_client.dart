import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';
import 'package:amity_sdk/public/public.dart';

class AmityCoreClient {
  static void setup({required AmityCoreClientOption option}) async {
    if (serviceLocator.isRegistered<AmityCoreClientOption>()) {
      serviceLocator.unregister<AmityCoreClientOption>();
    }
    serviceLocator.registerLazySingleton<AmityCoreClientOption>(() => option);
    await SdkServiceLocator.initServiceLocator();
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
