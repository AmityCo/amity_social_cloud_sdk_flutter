import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockChannelMemmberApiInterface extends Mock
    implements ChannelMemberApiInterface {}

// integration_test_id:ab491c4f-5839-48aa-a59d-fb6ed64b7681
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

  test('When user it baned, it should return success', () async {
    when(() => mockChannelMemberApiInterface
        .banMember(any<UpdateChannelMembersRequest>())).thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_channel_ban_member_success.json')
              .readAsString();
      return CreateChannelResponse.fromJson(json.decode(response));
    });

    final response = await AmityChatClient.newChannelRepository()
        .moderation(channelId)
        .banMembers(['userId']);

    expect(response, true);
  });
}
