import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockMessageApiInterface extends Mock implements MessageApiInterface {}

// integration_test_id:f0e869b8-3075-42a2-8ec1-f0ac0b41da02
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  String channelId = 'channelId';
  String message = 'message';

  final mockMessageApiInterface = MockMessageApiInterface();

  setUpAll(() async {
    registerFallbackValue(CreateMessageRequest(channelId: channelId));

    await AmityCoreClientMockSetup.setup();

    await AmityCoreClientMockSetup.loadMockSession();

    serviceLocator.registerLazySingleton<MessageApiInterface>(
      () => mockMessageApiInterface,
    );
  });

  test(
      'When the user creates a valid text message with @mention to a user that doesn\'t exist on the community channel. It should return a not found error (400400).',
      () async {
    when(() =>
            mockMessageApiInterface.createMessage(any<CreateMessageRequest>()))
        .thenThrow(AmityException(message: 'userId Not Found', code: 400400));

    try {
      await AmityChatClient.newMessageRepository()
          .createMessage(channelId)
          .text(message)
          .mentionChannel()
          .mentionUsers(['userId1', 'userId2']).send();
    } catch (error) {
      expect(error, isA<AmityException>());
      expect((error as AmityException).code, 400400);
    }
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
