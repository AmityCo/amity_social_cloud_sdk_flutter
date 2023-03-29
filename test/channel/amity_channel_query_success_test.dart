import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockChannelApiInterface extends Mock implements ChannelApiInterface {}

// integration_test_id:06c14dab-4799-4f26-9e52-be7c12b3bdb3
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final mockChannelApiInterface = MockChannelApiInterface();

  setUpAll(() async {
    registerFallbackValue(CreateChannelRequest());

    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<ChannelApiInterface>(
      () => mockChannelApiInterface,
    );

    registerFallbackValue(GetChannelRequest());
  });

  test('When user queries for existing chanenls, it should return valid list of channels (For all types)', () async {
    when(() => mockChannelApiInterface.getChannelQuery(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_channel_query_success.json').readAsString();
      return CreateChannelResponse.fromJson(json.decode(response));
    });

    final amityChannel = await AmityChatClient.newChannelRepository().getChannels().getPagingData();

    expect(amityChannel, isA<PageListData<List<AmityChannel>, String>>());
  });
}
