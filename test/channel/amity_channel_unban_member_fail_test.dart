import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockChannelMemmberApiInterface extends Mock
    implements ChannelMemberApiInterface {}

// integration_test_id:7e956594-00a5-469f-b51f-35d3428b000f
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

  test('When user without roles/not member unbans valid user in channel, it should return permission denied error', () async {
    when(() => mockChannelMemberApiInterface
        .unbanMember(any<UpdateChannelMembersRequest>())).thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_channel_unban_member_fail.json')
              .readAsString();
      return throw AmityErrorResponse.fromJson(json.decode(response))
          .amityException();
    });
    try {
    final response = await AmityChatClient.newChannelRepository()
        .moderation(channelId)
        .unbanMembers(['userId']);
    }catch (error) {
      expect(error, isA<AmityException>());
    }
  });
}
