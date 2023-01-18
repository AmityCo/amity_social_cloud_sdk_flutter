import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockMessageApiInterface extends Mock implements MessageApiInterface {}

// integration_test_id:2eeb7dbd-5902-43b0-8b16-9be2c2cb4b17
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
      'When the user gets a valid message with two mentioned users, it should return a valid message with two mentioned users.',
      () async {
    when(() =>
            mockMessageApiInterface.createMessage(any<CreateMessageRequest>()))
        .thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_message_text_with_mention.json')
              .readAsString();
      return CreateMessageResponse.fromJson(json.decode(response));
    });

    final amityMessage = await AmityChatClient.newMessageRepository()
        .createMessage(channelId)
        .text(message)
        .mentionChannel()
        .mentionUsers(['userId1', 'userId2']).send();

    expect(amityMessage, isA<AmityMessage>());
    expect(amityMessage.mentionees?.length ?? 0, 1);
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
