import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockChannelApiInterface extends Mock implements ChannelApiInterface {}

// integration_test_id:b331e01c-20db-4f17-979b-b280d8818792
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final communityId = '5f9f9b9c-9b9b-4b9b-9b9b-9b9b9b9b9b9b';

  final mockChannelApiInterface = MockChannelApiInterface();

  setUpAll(() async {
    registerFallbackValue(CreateChannelRequest());

    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<ChannelApiInterface>(
      () => mockChannelApiInterface,
    );
  });

  test('When user gets valid channel, it should return valid channel', () async {
    when(() => mockChannelApiInterface.getChannel(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_channel_get_success.json').readAsString();
      return CreateChannelResponse.fromJson(json.decode(response));
    });

    final amityChannel = await AmityChatClient.newChannelRepository().getChannel(communityId);

    expect(amityChannel, isA<AmityChannel>());
  });
}
