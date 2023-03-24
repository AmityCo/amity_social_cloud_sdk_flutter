import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommunityApiInterface extends Mock implements CommunityApiInterface {}

// integration_test_id:76a7982e-4671-4393-8c73-abf250a0e225
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

  test(
      'When the user delete a community that do not exist, It should return a not found error (400400: CommunityId [xxx] not found).',
      () async {
    when(() => mockCommunityApiInterface.deleteCommunity(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_community_delete_fail.json').readAsString();
      throw AmityErrorResponse.fromJson(json.decode(response)).amityException();
    });

    try {
      await AmitySocialClient.newCommunityRepository().deleteCommunity(communityId);
    } catch (error) {
      expect(error, isA<AmityException>());
    }
  });
}
