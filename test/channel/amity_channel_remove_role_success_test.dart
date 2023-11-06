import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockChannelMemmberApiInterface extends Mock
    implements ChannelMemberApiInterface {}

// integration_test_id:6b06f4f8-84ec-4b93-962e-9ee7b67ea488
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final channelId = '64f6e0ba7b4bc55ce06f9dd9';

  final mockChannelMemberApiInterface = MockChannelMemmberApiInterface();

  setUpAll(() async {
    registerFallbackValue(UpdateChannelRoleRequest(channelId: channelId , role: "" ,userIds: ['victimIOS'] ));

    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<ChannelMemberApiInterface>(
      () => mockChannelMemberApiInterface,
    );
  });

  test('When user removes role to valid user in channel, it should return a success result', () async {
    when(() => mockChannelMemberApiInterface
        .removeRole(any<UpdateChannelRoleRequest>())).thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_channel_remove_role_success.json')
              .readAsString();
      return CreateChannelResponse.fromJson(json.decode(response));
    });

    final response = await AmityChatClient.newChannelRepository().moderation(channelId).removeRole("",['victimIOS']);

    expect(response, null);
  });
}
