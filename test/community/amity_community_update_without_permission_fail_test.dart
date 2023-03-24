import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommunityApiInterface extends Mock implements CommunityApiInterface {}

// integration_test_id:b958b6fd-05d3-49c1-a486-f36fafecac41
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
      'When the user update a community without permission, it should return error (400301): You are not allowed to do this',
      () async {
    when(() => mockCommunityApiInterface.updateCommunity(any<CreateCommunityRequest>())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_community_update_fail_without_permission.json').readAsString();
      throw AmityErrorResponse.fromJson(json.decode(response)).amityException();
    });

    try {
      await AmitySocialClient.newCommunityRepository()
          .updateCommunity(communityId)
          .displayName('updated community name')
          .update();
    } catch (error) {
      expect(error, isA<AmityException>());
    }
  });
}
