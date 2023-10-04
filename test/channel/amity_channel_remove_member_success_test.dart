import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockChannelMemmberApiInterface extends Mock
    implements ChannelMemberApiInterface {}

// integration_test_id:fa47f7d9-2b60-4f4e-b65f-f3c3a7999a3f
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

  test('When user is removed, it should return success', () async {
    when(() => mockChannelMemberApiInterface
        .removeMember(any<UpdateChannelMembersRequest>())).thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_channel_remove_member_success.json')
              .readAsString();
      return CreateChannelResponse.fromJson(json.decode(response));
    });

    final response = await AmityChatClient.newChannelRepository()
        .removeMembers( channelId , ['userId']);

    expect(response, true);
  });
}
