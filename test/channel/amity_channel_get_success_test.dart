import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockChannelApiInterface extends Mock implements ChannelApiInterface {}

// integration_test_id:a715407a-e596-401e-9029-d6d84faa4a8f
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

  test('When the user get a valid community, it should return a valid community.', () async {
    when(() => mockChannelApiInterface.getChannel(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_channel_get_success.json').readAsString();
      return CreateChannelResponse.fromJson(json.decode(response));
    });

    final amityChannel = await AmityChatClient.newChannelRepository().getChannel(communityId);

    expect(amityChannel, isA<AmityChannel>());
  });
}
