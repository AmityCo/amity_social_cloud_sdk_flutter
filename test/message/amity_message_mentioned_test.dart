import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockMessageApiInterface extends Mock implements MessageApiInterface {}

// integration_test_id:115bcfbb-d517-4aca-bc5f-241b014d5602
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  String channelId = 'channelId';
  String message = 'message';

  final mockMessageApiInterface = MockMessageApiInterface();

  setUpAll(() async {
    registerFallbackValue(CreateMessageRequest(channelId: channelId));

    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<MessageApiInterface>(
      () => mockMessageApiInterface,
    );
  });

  test('When the user logs in to the system, it should return success',
      () async {
    when(() =>
            mockMessageApiInterface.createMessage(any<CreateMessageRequest>()))
        .thenAnswer((_) async {
      final response =
          await File('test/mock_json/session_response.json').readAsString();
      return CreateMessageResponse.fromJson(json.decode(response));
    });

    final amityUser = await AmityChatClient.newMessageRepository()
        .createMessage(channelId)
        .text(message)
        .mentionChannel()
        .mentionUsers(['userId1', 'userId2']).send();

    // expect(AmityCoreClient.getUserId(), userId);
    // expect(amityUser.userId, userId);
    // expect(amityUser.displayName, displayName);
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
