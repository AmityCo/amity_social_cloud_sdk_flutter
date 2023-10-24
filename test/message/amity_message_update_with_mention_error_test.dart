import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockMessageApiInterface extends Mock implements MessageApiInterface {}

// integration_test_id:c84d40a4-53c1-41f7-9143-7857709efa05
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
            mockMessageApiInterface.updateMessage(any<CreateMessageRequest>()))
        .thenThrow(AmityException(message: 'userId Not Found', code: 400400));

    try {
      await AmityChatClient.newMessageRepository()
          .updateMessage(channelId , message).text(message).update();
    } catch (error) {
      expect(error, isA<AmityException>());
      expect((error as AmityException).code, 400400);
    }
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
