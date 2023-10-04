import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockChannelMemmberApiInterface extends Mock
    implements ChannelMemberApiInterface {}

// integration_test_id:c0df362e-dd03-4c81-9532-8c6702784333
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final channelId = '64f6e0ba7b4bc55ce06f9dd9';

  final mockChannelMemberApiInterface = MockChannelMemmberApiInterface();

  setUpAll(() async {
    registerFallbackValue(UpdateChannelMembersRequest(channelId: channelId));

    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<ChannelMemberApiInterface>(
      () => mockChannelMemberApiInterface,
    );
  });

  test(
      'When user unmutes invalid/not member user in channel, it should reutrn not found error',
      () async {
    when(() => mockChannelMemberApiInterface
        .muteMember(any<UpdateChannelMembersRequest>())).thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_channel_unmute_member_fail.json').readAsString();
      return throw AmityErrorResponse.fromJson(json.decode(response))
          .amityException();
    });

    try {
      final response = await AmityChatClient.newChannelRepository()
          .moderation(channelId)
          .muteMembers(['userId']);
    } catch (error) {
      expect(error, isA<AmityException>());
    }
  });
}
