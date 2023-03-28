import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockChannelApiInterface extends Mock implements ChannelApiInterface {}

// integration_test_id:da9dc3e8-01fd-4e76-a26b-ac8333a69b23
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

  test('When user queries invalid channel, it should return error', () async {
    when(() => mockChannelApiInterface.getChannel(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_channel_get_fail.json').readAsString();
      throw AmityErrorResponse.fromJson(json.decode(response)).amityException();
    });

    try {
      await AmityChatClient.newChannelRepository().getChannel(channelId);
    } catch (error) {
      expect(error, isA<AmityException>());
    }
  });
}
