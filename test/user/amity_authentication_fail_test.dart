import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockAuthenticationApiInterface extends Mock
    implements AuthenticationApiInterface {}

// integration_test_id:f52e7ba1-b1a8-4e6b-9439-b22658d29879
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

  test(
      'When the user logs in to the system with invalid user, it should return UnAuthorize Error',
      () async {
    when(() => authenticationApiInterface.login(any<AuthenticationRequest>()))
        .thenThrow(AmityException);

    try {
      final amityUser =
          await AmityCoreClient.login(userId).displayName(displayName).submit();
    } catch (error) {
      expect(error, AmityException);
    }
  });
}
