import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommunityApiInterface extends Mock implements CommunityApiInterface {}

// integration_test_id:e89eae1f-3604-4c1f-816b-b58e9a9f40e9
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

  test('When the user update a valid community, it should return a valid community.', () async {
    when(() => mockCommunityApiInterface.updateCommunity(any<CreateCommunityRequest>())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_community_create_success.json').readAsString();
      return CreateCommunityResponse.fromJson(json.decode(response));
    });

    final amityCommunity = await AmitySocialClient.newCommunityRepository()
        .updateCommunity(communityId)
        .displayName('updated community name')
        .update();

    expect(amityCommunity, isA<AmityCommunity>());
  });
}
