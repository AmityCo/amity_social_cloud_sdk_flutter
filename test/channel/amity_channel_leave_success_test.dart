import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockChannelMemmberApiInterface extends Mock implements ChannelMemberApiInterface {}

// integration_test_id:1880da39-bac6-4259-9d44-18f04193c407
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final communityId = '5f9f9b9c-9b9b-4b9b-9b9b-9b9b9b9b9b9b';

  final mockChannelMemberApiInterface = MockChannelMemmberApiInterface();

  setUpAll(() async {
    registerFallbackValue(CreateChannelRequest());

    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<ChannelMemberApiInterface>(
      () => mockChannelMemberApiInterface,
    );
  });

  test('When the user join a valid community, it should return `true` value.', () async {
    when(() => mockChannelMemberApiInterface.leaveChannel(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_channel_leave_success.json').readAsString();
      return CreateChannelResponse.fromJson(json.decode(response));
    });

    final response = await AmityChatClient.newChannelRepository().leaveChannel(communityId);

    expect(response, true);
  });
}
