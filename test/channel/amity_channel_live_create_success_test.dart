import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockChannelApiInterface extends Mock implements ChannelApiInterface {}

// integration_test_id:cef520ab-027d-4c5b-836c-a7f63ddc5146
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

  test('When user creates valid live channel, it should return live channel', () async {
    when(() => mockChannelApiInterface.createChannel(any<CreateChannelRequest>())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_channel_create_live_success.json').readAsString();
      return CreateChannelResponse.fromJson(json.decode(response));
    });

    final amityChannel =
        await AmityChatClient.newChannelRepository().createChannel().liveType().withDisplayName(displayName).create();

    expect(amityChannel, isA<AmityChannel>());
    expect(amityChannel.amityChannelType, AmityChannelType.LIVE);
  });
}
