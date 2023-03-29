import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockChannelApiInterface extends Mock implements ChannelApiInterface {}

// integration_test_id:365abf56-c6f7-4e40-85fe-b1951509a442
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final channelId = '5f9f9b9c-9b9b-4b9b-9b9b-9b9b9b9b9b9b';

  final mockChannelApiInterface = MockChannelApiInterface();

  setUpAll(() async {
    registerFallbackValue(CreateChannelRequest());

    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<ChannelApiInterface>(
      () => mockChannelApiInterface,
    );
  });

  test('When user updates valid channel, it should return updated channel', () async {
    when(() => mockChannelApiInterface.updateChannel(any<CreateChannelRequest>())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_channel_update_success.json').readAsString();
      return CreateChannelResponse.fromJson(json.decode(response));
    });

    final amityChannel = await AmityChatClient.newChannelRepository()
        .updateChannel(channelId)
        .displayName('updated channel name')
        .create();

    expect(amityChannel, isA<AmityChannel>());
  });
}
