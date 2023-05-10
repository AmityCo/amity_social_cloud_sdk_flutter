import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommunityMemmberApiInterface extends Mock implements CommunityMemmberApiInterface {}

// integration_test_id:41c71553-1f0c-447f-9efc-e4e48e58566d
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

  test('When the user leave a valid community, it should return `true` value.', () async {
    when(() => mockCommunityMemberApiInterface.leaveCommunity(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_community_leave_success.json').readAsString();
      return GetCommunityMembersResponse.fromJson(json.decode(response));
    });

    final response = await AmitySocialClient.newCommunityRepository().leaveCommunity(communityId);

    expect(response, true);
  });
}
