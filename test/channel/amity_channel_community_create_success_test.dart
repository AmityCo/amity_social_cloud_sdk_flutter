import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockChannelApiInterface extends Mock implements ChannelApiInterface {}

// integration_test_id:9d80fd54-9e6d-454d-8344-6f9436b8e495
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final displayName = 'Flutter Unit Test Community';
  final mockChannelApiInterface = MockChannelApiInterface();

  setUpAll(() async {
    registerFallbackValue(CreateChannelRequest());

    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<ChannelApiInterface>(
      () => mockChannelApiInterface,
    );
  });

  test('When user creates valid community channel, it should return valid channel', () async {
    when(() => mockChannelApiInterface.createChannel(any<CreateChannelRequest>())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_channel_create_community_success.json').readAsString();
      return CreateChannelResponse.fromJson(json.decode(response));
    });

    final amityChannel = await AmityChatClient.newChannelRepository()
        .createChannel()
        .communityType()
        .withDisplayName(displayName)
        .create();

    expect(amityChannel, isA<AmityChannel>());
    expect(amityChannel.amityChannelType, AmityChannelType.COMMUNITY);
  });
}
