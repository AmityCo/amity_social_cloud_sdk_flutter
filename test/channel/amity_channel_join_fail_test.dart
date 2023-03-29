import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockChannelMemberApiInterface extends Mock implements ChannelMemberApiInterface {}

// integration_test_id:402a8cd8-6522-42d0-8f40-ccccae0093a1
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final channelId = '5f9f9b9c-9b9b-4b9b-9b9b-9b9b9b9b9b9b';

  final mockChannelMemberApiInterface = MockChannelMemberApiInterface();

  setUpAll(() async {
    registerFallbackValue(CreateChannelRequest());

    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<ChannelMemberApiInterface>(
      () => mockChannelMemberApiInterface,
    );
  });

  test('When user joins channel which does not exist, it should return error (400400)', () async {
    when(() => mockChannelMemberApiInterface.joinChannel(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_channel_join_fail.json').readAsString();
      throw AmityErrorResponse.fromJson(json.decode(response)).amityException();
    });

    try {
      await AmityChatClient.newChannelRepository().joinChannel(channelId);
    } catch (error) {
      expect(error, isA<AmityException>());
    }
  });
}
