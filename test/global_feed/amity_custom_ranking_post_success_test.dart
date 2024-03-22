import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockGlobalFeedApiInterface extends Mock
    implements GlobalFeedApiInterface {}

// integration_test_id:f7131daf-1d18-4ec3-b444-877a45a5ddd4
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final mockGlobalFeedApiInterface = MockGlobalFeedApiInterface();

  setUpAll(() async {
    registerFallbackValue(GetGlobalFeedRequest());
    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<GlobalFeedApiInterface>(
      () => mockGlobalFeedApiInterface,
    );
  });

  test(
      'When user query posts from custom post ranking global feed, it should return valid posts.',
      () async {
    when(() => mockGlobalFeedApiInterface.getCustomPostRanking(any()))
        .thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_global_custom_post_ranking_success.json').readAsString();
      return CreatePostResponse.fromJson(json.decode(response));
    });

    final amityFeedsPage = await
        AmitySocialClient.newFeedRepository()
          .getCustomRankingGlobalFeed()
          .getPagingData(token: "", limit: 10);

    final feeds = amityFeedsPage.data;

    expect(feeds, isList);
    expect(feeds[0], isA<AmityPost>());
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
