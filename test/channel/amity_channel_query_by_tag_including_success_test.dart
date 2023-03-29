import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockChannelApiInterface extends Mock implements ChannelApiInterface {}

// integration_test_id:92329d41-9403-44e7-979f-ed227e6ab120
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final mockChannelApiInterface = MockChannelApiInterface();
  final tags = ['tags'];
  setUpAll(() async {
    registerFallbackValue(CreateChannelRequest());

    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<ChannelApiInterface>(
      () => mockChannelApiInterface,
    );

    registerFallbackValue(GetChannelRequest());
  });

  test('When user filters channels by including tags, it should return channels which contains such tags', () async {
    when(() => mockChannelApiInterface.getChannelQuery(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_channel_query_tag_include_success.json').readAsString();
      return CreateChannelResponse.fromJson(json.decode(response));
    });

    final amityChannel = await AmityChatClient.newChannelRepository().getChannels().includingTags(tags).getPagingData();

    expect(amityChannel, isA<PageListData<List<AmityChannel>, String>>());
  });
}
