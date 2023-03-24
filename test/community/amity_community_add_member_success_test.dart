import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommunityMemmberApiInterface extends Mock implements CommunityMemmberApiInterface {}

// integration_test_id:f8977312-a294-48ed-993f-38b5ff01ce8e
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

  test('When the user add valid member to community, it should return `true` value.', () async {
    when(() => mockCommunityMemberApiInterface.addMember(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_community_add_member_success.json').readAsString();
      return GetCommunityMembersResponse.fromJson(json.decode(response));
    });

    final response = await AmitySocialClient.newCommunityRepository().membership(communityId).addMembers([userId]);

    expect(response, true);
  });
}
