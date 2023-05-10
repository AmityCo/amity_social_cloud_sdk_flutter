import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockChannelApiInterface extends Mock implements ChannelApiInterface {}

// integration_test_id:5249778c-6d99-4e2f-9b80-2f4ea6ae1833
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

  test('When user filters channels by excluding tags, it should return channels which do not contain such tags',
      () async {
    when(() => mockChannelApiInterface.getChannelQuery(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_channel_query_tag_exnclude_success.json').readAsString();
      return CreateChannelResponse.fromJson(json.decode(response));
    });

    final amityChannel = await AmityChatClient.newChannelRepository().getChannels().excludingTags(tags).getPagingData();

    expect(amityChannel, isA<PageListData<List<AmityChannel>, String>>());
  });
}
