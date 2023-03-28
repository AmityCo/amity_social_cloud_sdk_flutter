import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockChannelApiInterface extends Mock implements ChannelApiInterface {}

// integration_test_id:bced54e1-b3c1-4253-bb1b-b1e1b495bef5
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

  test('When user tries to update channel where he is not the creator, it should return error (400301)', () async {
    when(() => mockChannelApiInterface.updateChannel(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_channel_update_fail.json').readAsString();
      throw AmityErrorResponse.fromJson(json.decode(response)).amityException();
    });

    try {
      await AmityChatClient.newChannelRepository()
          .updateChannel(channelId)
          .displayName('updated channel name')
          .create();
    } catch (error) {
      expect(error, isA<AmityException>());
    }
  });
}
