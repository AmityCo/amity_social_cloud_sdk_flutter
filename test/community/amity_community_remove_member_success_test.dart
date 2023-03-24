import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommunityMemmberApiInterface extends Mock implements CommunityMemmberApiInterface {}

// integration_test_id:35392bb1-aabe-45de-a220-9fb15f80af62
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final userId = 'victimAndroid';
  final communityId = '5f9f9b9c-9b9b-4b9b-9b9b-9b9b9b9b9b9b';

  final mockCommunityMemberApiInterface = MockCommunityMemmberApiInterface();

  setUpAll(() async {
    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<CommunityMemmberApiInterface>(
      () => mockCommunityMemberApiInterface,
    );
    registerFallbackValue(UpdateCommunityMembersRequest(communityId: communityId, userIds: [userId]));
  });

  test('When the user remove valid member to community, it should return `true` value.', () async {
    when(() => mockCommunityMemberApiInterface.removeMember(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_community_remove_member_success.json').readAsString();
      return GetCommunityMembersResponse.fromJson(json.decode(response));
    });

    final response = await AmitySocialClient.newCommunityRepository().membership(communityId).removeMembers([userId]);

    expect(response, true);
  });
}
