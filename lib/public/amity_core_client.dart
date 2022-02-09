import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/public/query_builder/login_query_builder.dart';

class AmityCoreClient {
  static void setup({required AmityCoreClientOption option}) {
    sl.unregister<AmityCoreClientOption>();
    sl.registerLazySingleton<AmityCoreClientOption>(() => option);
    SdkServiceLocator.initServiceLocator();
  }

  LoginQueryBuilder login(String userId) {
    return LoginQueryBuilder(useCase: sl(), userId: userId);
  }
}

class AmityCoreClientOption {
  final String apiKey;
  final AmityRegionalHttpEndpoint httpEndpoint;
  final AmityRegionalSocketEndpoint socketEndpoint;

  AmityCoreClientOption(
      {required this.apiKey,
      this.httpEndpoint = AmityRegionalHttpEndpoint.SG,
      this.socketEndpoint = AmityRegionalSocketEndpoint.SG});
}
