import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommunityMemmberApiInterface extends Mock implements CommunityMemmberApiInterface {}

// integration_test_id:1880da39-bac6-4259-9d44-18f04193c407
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

  test('When the user join a valid community, it should return `true` value.', () async {
    when(() => mockCommunityMemberApiInterface.joinCommunity(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_community_join_success.json').readAsString();
      return GetCommunityMembersResponse.fromJson(json.decode(response));
    });

    final response = await AmitySocialClient.newCommunityRepository().joinCommunity(communityId);

    expect(response, true);
  });
}
