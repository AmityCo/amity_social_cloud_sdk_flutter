import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockMessageApiInterface extends Mock implements MessageApiInterface {}

// integration_test_id:5c6b5a0a-628d-4834-8453-d11df656dea8
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  String messageId = '650bfbeb6d2464171b0c2b90';

  final mockMessageApiInterface = MockMessageApiInterface();

  setUpAll(() async {
    registerFallbackValue(String);

    await AmityCoreClientMockSetup.setup();

    await AmityCoreClientMockSetup.loadMockSession();

    serviceLocator.registerLazySingleton<MessageApiInterface>(
      () => mockMessageApiInterface,
    );
  });

  test(
      'When user unflags a message with invalid messageId, it should return error (400400).',
      () async {
    when(() =>
            mockMessageApiInterface.unFlagMessage(any<String>()))
        .thenThrow(AmityException(message: 'userId Not Found', code: 400400));

    try {
      await AmityChatClient.newMessageRepository()
          .unflag(messageId);
    } catch (error) {
      expect(error, isA<AmityException>());
      expect((error as AmityException).code, 400400);
    }
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
