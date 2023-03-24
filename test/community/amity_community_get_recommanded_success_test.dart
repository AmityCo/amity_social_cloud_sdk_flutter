import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommunityApiInterface extends Mock implements CommunityApiInterface {}

// integration_test_id:42f56f3e-9879-4a06-9173-9537a27465ca
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

  test('When the user get a valid recommended communities, it should return a valid recommended communities.',
      () async {
    when(() => mockCommunityApiInterface.getTopTredningCommunity(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_communiyt_get_recommended_success.json').readAsString();
      return CreateCommunityResponse.fromJson(json.decode(response));
    });

    final amityCommunity = await AmitySocialClient.newCommunityRepository().getTrendingCommunities();

    expect(amityCommunity, isA<List<AmityCommunity>>());
  });
}
