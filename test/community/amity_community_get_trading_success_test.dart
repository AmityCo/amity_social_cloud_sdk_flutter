import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommunityApiInterface extends Mock implements CommunityApiInterface {}

// integration_test_id:bbc532ac-7f37-4118-8a00-eed1ecf892ec
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final mockCommunityApiInterface = MockCommunityApiInterface();

  setUpAll(() async {
    registerFallbackValue(CreateCommunityRequest());

    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<CommunityApiInterface>(
      () => mockCommunityApiInterface,
    );

    registerFallbackValue(OptionsRequest(limit: 5));
  });

  test('When the user get a valid trending communities, it should return a valid trending  communities.', () async {
    when(() => mockCommunityApiInterface.getTopTredningCommunity(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_communiyt_get_recommended_success.json').readAsString();
      return CreateCommunityResponse.fromJson(json.decode(response));
    });

    final amityCommunity = await AmitySocialClient.newCommunityRepository().getTrendingCommunities();

    expect(amityCommunity, isA<List<AmityCommunity>>());
  });
}
