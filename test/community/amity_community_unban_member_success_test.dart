import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommunityMemmberApiInterface extends Mock implements CommunityMemmberApiInterface {}

// integration_test_id:bee19fd4-63f4-403f-9771-6424d94cf144
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

  test('When the user unban community member, it should return `true` value.', () async {
    when(() => mockCommunityMemberApiInterface.unbanMember(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_community_ban_member_success.json').readAsString();
      return GetCommunityMembersResponse.fromJson(json.decode(response));
    });

    final response = await AmitySocialClient.newCommunityRepository().moderation(communityId).unbanMember([userId]);

    expect(response, true);
  });
}
