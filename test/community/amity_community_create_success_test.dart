import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommunityApiInterface extends Mock implements CommunityApiInterface {}

// integration_test_id:9c814bd0-903b-4ec0-938c-9923bd6c75d6
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final mockCommunityApiInterface = MockCommunityApiInterface();

  setUpAll(() async {
    registerFallbackValue(CreateCommunityRequest());

    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<CommunityApiInterface>(
      () => mockCommunityApiInterface,
    );
  });

  test('When the user creates a valid community, it should return a valid community.', () async {
    when(() => mockCommunityApiInterface.createCommunity(any<CreateCommunityRequest>())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_community_create_success.json').readAsString();
      return CreateCommunityResponse.fromJson(json.decode(response));
    });

    final amityCommunity = await AmitySocialClient.newCommunityRepository()
        .createCommunity('Flutter Unit Test Community')
        .description('Flutter Unit Test Community Description')
        .isPublic(true)
        .create();

    expect(amityCommunity, isA<AmityCommunity>());
  });
}
