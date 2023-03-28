import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockChannelMemberApiInterface extends Mock implements ChannelMemberApiInterface {}

// integration_test_id:4f56790e-5fa0-4d04-8c20-ab0c39d0776f
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

  test('When user leaves not joined channel, it should return error (400301)', () async {
    when(() => mockChannelMemberApiInterface.leaveChannel(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_channel_leave_fail.json').readAsString();
      throw AmityErrorResponse.fromJson(json.decode(response)).amityException();
    });

    try {
      await AmityChatClient.newChannelRepository().leaveChannel(channelId);
    } catch (error) {
      expect(error, isA<AmityException>());
    }
  });
}
