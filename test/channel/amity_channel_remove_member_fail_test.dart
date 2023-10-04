import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockChannelMemmberApiInterface extends Mock
    implements ChannelMemberApiInterface {}

// integration_test_id:a9d13eff-5e17-4fc5-b20e-43c568aa8c23
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

  test('When user with roles removes banned user to channel, it should return user is banned from a channel', () async {
    when(() => mockChannelMemberApiInterface.removeMember(
        any<UpdateChannelMembersRequest>())).thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_channel_remove_member_fail.json')
              .readAsString();
      return throw AmityErrorResponse.fromJson(json.decode(response)).amityException();
    });

    try {
      final response = await AmityChatClient.newChannelRepository().removeMembers(channelId, ['userId']);
    } catch (error) {
      expect(error, isA<AmityException>());
    }
  });
}
