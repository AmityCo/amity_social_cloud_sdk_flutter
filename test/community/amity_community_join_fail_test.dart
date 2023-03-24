import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommunityMemmberApiInterface extends Mock implements CommunityMemmberApiInterface {}

// integration_test_id:1845a150-82a8-4ed2-b547-96b41ab63401
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final communityId = '5f9f9b9c-9b9b-4b9b-9b9b-9b9b9b9b9b9b';

  final mockCommunityMemberApiInterface = MockCommunityMemmberApiInterface();

  setUpAll(() async {
    registerFallbackValue(CreateCommunityRequest());

    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<CommunityMemmberApiInterface>(
      () => mockCommunityMemberApiInterface,
    );
  });

  test('When banned user join a community, It should return error (400304: User is banned from a channel / community.)',
      () async {
    when(() => mockCommunityMemberApiInterface.joinCommunity(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_community_join_fail.json').readAsString();
      throw AmityErrorResponse.fromJson(json.decode(response)).amityException();
    });

    try {
      await AmitySocialClient.newCommunityRepository().joinCommunity(communityId);
    } catch (error) {
      expect(error, isA<AmityException>());
    }
  });
}
