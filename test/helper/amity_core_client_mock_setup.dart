import 'package:amity_sdk/src/src.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'hive_extension.dart';

class AmityCoreClientMockSetup {
  static Future setup() async {
    await HiveInit.main(DateTime.now().toIso8601String());
    Hive.resetAdapters();
    await AmityCoreClient.setup(
      option: AmityCoreClientOption(
          apiKey: 'apikey',
          httpEndpoint: AmityRegionalHttpEndpoint.SG,
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
    serviceLocator<AccountDbAdapter>().saveAccountEntity(AccountHiveEntity(
        userId: 'userId',
        displayName: 'displayName',
        deviceId: const Uuid().v1()));
  }
}
