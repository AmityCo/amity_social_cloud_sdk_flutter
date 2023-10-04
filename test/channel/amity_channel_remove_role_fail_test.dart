import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockChannelMemmberApiInterface extends Mock
    implements ChannelMemberApiInterface {}

// integration_test_id:3b42007d-adbe-471d-a89e-3623436d8935
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final channelId = '64f6e0ba7b4bc55ce06f9dd9';

  final mockChannelMemberApiInterface = MockChannelMemmberApiInterface();

  setUpAll(() async {
    registerFallbackValue(UpdateChannelRoleRequest(
        channelId: channelId, role: "", userIds: ['victimIOS']));

    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<ChannelMemberApiInterface>(
      () => mockChannelMemberApiInterface,
    );
  });

  test(
      'When user removes role to invalid/not member user in channel, it should return not found error (400400)',
      () async {
    when(() => mockChannelMemberApiInterface
        .removeRole(any<UpdateChannelRoleRequest>())).thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_channel_remove_role_fail.json')
              .readAsString();
      return throw AmityErrorResponse.fromJson(json.decode(response))
          .amityException();
    });

    try {
      final response = await AmityChatClient.newChannelRepository()
          .moderation(channelId)
          .removeRole("", ['victimIOS']);
    } catch (error) {
      expect(error, isA<AmityException>());
    }
  });
}
