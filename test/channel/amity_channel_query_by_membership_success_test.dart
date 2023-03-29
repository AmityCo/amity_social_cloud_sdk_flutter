import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockChannelApiInterface extends Mock implements ChannelApiInterface {}

// integration_test_id:253fb0ac-f868-4570-9b1e-98b08861aa53
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

  test('When user filters channels by membership, it should return channel which matches those membership status',
      () async {
    when(() => mockChannelApiInterface.getChannelQuery(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_channel_query_member_success.json').readAsString();
      return CreateChannelResponse.fromJson(json.decode(response));
    });

    final amityChannel =
        await AmityChatClient.newChannelRepository().getChannels().filter(AmityChannelFilter.MEMBER).getPagingData();

    expect(amityChannel, isA<PageListData<List<AmityChannel>, String>>());
  });
}
