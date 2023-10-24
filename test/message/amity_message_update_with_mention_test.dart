import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockMessageApiInterface extends Mock implements MessageApiInterface {}

// integration_test_id:4d135298-2d49-4d8e-8a8d-57ed6c60d835
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  String channelId = 'channelId';
  String message = 'message';
  String messageId = 'messageId';

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
      'When the user creates a valid text message with @mention to two users on the community channel. It should return a valid text message with mention ',
      () async {
    when(() =>
            mockMessageApiInterface.updateMessage(any<CreateMessageRequest>()))
        .thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_message_text_with_mention.json')
              .readAsString();
      return CreateMessageResponse.fromJson(json.decode(response));
    });

    final amityMessage = await AmityChatClient.newMessageRepository()
        .updateMessage(channelId , message).text(message).update();

    expect(amityMessage, isA<AmityMessage>());
    expect(amityMessage.mentionees?.length ?? 0, 1);
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}