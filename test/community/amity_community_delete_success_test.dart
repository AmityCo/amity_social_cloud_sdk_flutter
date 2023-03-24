import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommunityApiInterface extends Mock implements CommunityApiInterface {}

// integration_test_id:7eef7123-21b9-4f56-acc8-8460cba5668f
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

  test('When the user delete a valid community, it should return a valid community.', () async {
    when(() => mockCommunityApiInterface.deleteCommunity(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_community_delete_success.json').readAsString();
      return true;
    });

    final response = await AmitySocialClient.newCommunityRepository().deleteCommunity(communityId);

    expect(response, true);
  });
}
