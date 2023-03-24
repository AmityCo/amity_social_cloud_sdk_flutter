import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommunityApiInterface extends Mock implements CommunityApiInterface {}

// integration_test_id:5fcdea0f-a1ad-4059-bad1-5760a904e481
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

  test(
      'When the user creates a community using these reference IDs `avatarFileId`, `userIds`, `categoryIds` that do not exist, It should return a not found error (400400: Resource Not Found).',
      () async {
    when(() => mockCommunityApiInterface.createCommunity(any<CreateCommunityRequest>())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_community_create_fail.json').readAsString();
      throw AmityErrorResponse.fromJson(json.decode(response)).amityException();
    });

    try {
      await AmitySocialClient.newCommunityRepository()
          .createCommunity('Flutter Unit Test Community')
          .description('Flutter Unit Test Community Description')
          .isPublic(true)
          .create();
    } catch (error) {
      expect(error, isA<AmityException>());
    }
  });
}
