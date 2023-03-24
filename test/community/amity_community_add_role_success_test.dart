import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommunityMemmberApiInterface extends Mock implements CommunityMemmberApiInterface {}

// integration_test_id:11135891-953f-45d8-b9f6-a2f83ddfdea3
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
    registerFallbackValue(UpdateCommunityRoleRequest(communityId: communityId, userIds: [userId], role: communityRole));
  });

  test('When the user add valid role to community, it should return `true` value.', () async {
    when(() => mockCommunityMemberApiInterface.addRole(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_community_add_role_member_success.json').readAsString();
      return GetCommunityMembersResponse.fromJson(json.decode(response));
    });

    final response =
        await AmitySocialClient.newCommunityRepository().moderation(communityId).addRole(communityRole, [userId]);

    expect(response, true);
  });
}
