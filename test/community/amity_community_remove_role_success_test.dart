import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommunityMemmberApiInterface extends Mock implements CommunityMemmberApiInterface {}

// integration_test_id:6413395d-e69d-42e9-92ab-0feed1d5c5a3
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final userId = 'victimAndroid';
  final communityId = '5f9f9b9c-9b9b-4b9b-9b9b-9b9b9b9b9b9b';
  final communityRole = 'community-role';

  final mockCommunityMemberApiInterface = MockCommunityMemmberApiInterface();

  setUpAll(() async {
    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<CommunityMemmberApiInterface>(
      () => mockCommunityMemberApiInterface,
    );
    registerFallbackValue(UpdateCommunityRoleRequest(
      communityId: communityId,
      userIds: [userId],
      role: communityRole,
    ));
  });

  test('When the user remove valid role to community, it should return `true` value.', () async {
    when(() => mockCommunityMemberApiInterface.removeRole(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_community_remove_role_member_success.json').readAsString();
      return GetCommunityMembersResponse.fromJson(json.decode(response));
    });

    final response =
        await AmitySocialClient.newCommunityRepository().moderation(communityId).removeRole(communityRole, [userId]);

    expect(response, true);
  });
}
