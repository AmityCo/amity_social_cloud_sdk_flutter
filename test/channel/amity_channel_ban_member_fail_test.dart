import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockChannelMemmberApiInterface extends Mock
    implements ChannelMemberApiInterface {}

// integration_test_id:622c26a0-2e75-4e90-ab1e-915a0a30b577
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

  test('When user without roles/not member bans valid user in channel, it should return permission denied error', () async {
    when(() => mockChannelMemberApiInterface
        .banMember(any<UpdateChannelMembersRequest>())).thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_channel_unban_member_fail.json')
              .readAsString();
      return throw AmityErrorResponse.fromJson(json.decode(response))
          .amityException();
    });
    try {
    final response = await AmityChatClient.newChannelRepository()
        .moderation(channelId)
        .banMembers(['userId']);
    }catch (error) {
      expect(error, isA<AmityException>());
    }
  });
}
