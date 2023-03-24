import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommunityMemmberApiInterface extends Mock implements CommunityMemmberApiInterface {}

// integration_test_id:39b01f58-5557-4b71-b5ab-890cbd7cc1be
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

  test(
      'When the user add role to community without permission, it should return error (400301): You are not allowed to do this',
      () async {
    when(() => mockCommunityMemberApiInterface.addRole(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_community_add_role_member_fail.json').readAsString();
      throw AmityErrorResponse.fromJson(json.decode(response)).amityException();
    });

    try {
      await AmitySocialClient.newCommunityRepository().moderation(communityId).addRole(communityRole, [userId]);
    } catch (error) {
      expect(error, isA<AmityException>());
      expect((error as AmityException).code, 400301);
    }
  });
}
