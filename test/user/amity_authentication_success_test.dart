import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockAuthenticationApiInterface extends Mock
    implements AuthenticationApiInterface {}

// integration_test_id:115bcfbb-d517-4aca-bc5f-241b014d5602
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  String userId = 'victimAndroid';
  String displayName = 'Victim Android';

  final authenticationApiInterface = MockAuthenticationApiInterface();

  setUpAll(() async {
    registerFallbackValue(
        AuthenticationRequest(userId: userId, displayName: displayName));

    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<AuthenticationApiInterface>(
      () => authenticationApiInterface,
    );
  });

  test('When the user logs in to the system, it should return success',
      () async {
    when(() => authenticationApiInterface.login(any<AuthenticationRequest>()))
        .thenAnswer((_) async {
      final response =
          await File('test/mock_json/session_response.json').readAsString();
      return SessionResponse.fromJson(json.decode(response));
    });

    final amityUser =
        await AmityCoreClient.login(userId).displayName(displayName).submit();

    // expect(AmityCoreClient.getUserId(), userId);
    expect(amityUser.userId, userId);
    expect(amityUser.displayName, displayName);
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
