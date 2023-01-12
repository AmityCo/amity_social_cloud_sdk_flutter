import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/hive_extension.dart';

class MockAuthenticationApiInterface extends Mock
    implements AuthenticationApiInterface {}

// integration_test_id:115bcfbb-d517-4aca-bc5f-241b014d5602
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  String userId = 'userId';
  String displayName = 'displayName';

  late MockAuthenticationApiInterface authenticationRepo;

  setUpAll(() async {
    await HiveInit.main();
    authenticationRepo = MockAuthenticationApiInterface();

    // registerFallbackValue(
    //     AuthenticationRequest(userId: userId, displayName: displayName));

    when(() => authenticationRepo.login(
            AuthenticationRequest(userId: userId, displayName: displayName)))
        .thenAnswer((_) async {
      final response =
          await File('/test/mock_json/session_response.json').readAsString();
      return SessionResponse.fromJson(json.decode(response));
    });
  });
  test('AmityCore Login Test', () async {
    await AmityCoreClient.setup(
      option: AmityCoreClientOption(
          apiKey: 'apikey',
          httpEndpoint: AmityRegionalHttpEndpoint.STAGING,
          showLogs: true),
      sycInitialization: true,
    );

    serviceLocator.registerLazySingleton<AuthenticationApiInterface>(
      () => MockAuthenticationApiInterface(),
    );

    final amityUser =
        await AmityCoreClient.login(userId).displayName(displayName).submit();

    // expect(AmityCoreClient.getUserId(), userId);
    expect(amityUser.userId, userId);
    expect(amityUser.displayName, displayName);
  });
}
