import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockChannelApiInterface extends Mock implements ChannelApiInterface {}

// integration_test_id:9c814bd0-903b-4ec0-938c-9923bd6c75d6
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final userId = 'victimAndroid';
  final mockChannelApiInterface = MockChannelApiInterface();

  setUpAll(() async {
    registerFallbackValue(CreateChannelRequest());

    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<ChannelApiInterface>(
      () => mockChannelApiInterface,
    );
  });

  test('When the user creates a valid community, it should return a valid community.', () async {
    when(() => mockChannelApiInterface.createConversationChannel(any<CreateChannelRequest>())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_channel_create_conversation_success.json').readAsString();
      return CreateChannelResponse.fromJson(json.decode(response));
    });

    final amityChannel =
        await AmityChatClient.newChannelRepository().createChannel().conversationType().withUserId(userId).create();

    expect(amityChannel, isA<AmityChannel>());
    expect(amityChannel.amityChannelType, AmityChannelType.CONVERSATION);
  });
}
