import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommunityApiInterface extends Mock implements CommunityApiInterface {}

// integration_test_id:a715407a-e596-401e-9029-d6d84faa4a8f
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final communityId = '5f9f9b9c-9b9b-4b9b-9b9b-9b9b9b9b9b9b';

  final mockCommunityApiInterface = MockCommunityApiInterface();

  setUpAll(() async {
    registerFallbackValue(CreateCommunityRequest());

    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<CommunityApiInterface>(
      () => mockCommunityApiInterface,
    );
  });

  test('When the user get a valid community, it should return a valid community.', () async {
    when(() => mockCommunityApiInterface.getCommunity(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_communiyt_get_success.json').readAsString();
      return CreateCommunityResponse.fromJson(json.decode(response));
    });

    final amityCommunity = await AmitySocialClient.newCommunityRepository().getCommunity(communityId);

    expect(amityCommunity, isA<AmityCommunity>());
  });
}
