import 'package:amity_sdk/src/src.dart';

import 'hive_extension.dart';

class AmityCoreClientMockSetup {
  static Future setup() async {
    await HiveInit.main(DateTime.now().toIso8601String());

    await AmityCoreClient.setup(
      option: AmityCoreClientOption(
          apiKey: 'apikey',
          httpEndpoint: AmityRegionalHttpEndpoint.STAGING,
          showLogs: true),
      sycInitialization: true,
    );
  }

  static Future loadMockSession() async {
    serviceLocator.registerSingleton<AmityUser>(AmityUser()
      ..userId = 'userId'
      ..displayName = 'displayName');
    serviceLocator.registerSingleton<SessionResponse>(SessionResponse(
        accessToken: 'mockAccessToken',
        refreshToken: 'mockRefreshToken',
        users: [],
        files: []));
  }
}
