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
}
