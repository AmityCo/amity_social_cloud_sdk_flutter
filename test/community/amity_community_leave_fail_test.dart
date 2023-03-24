import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommunityMemmberApiInterface extends Mock implements CommunityMemmberApiInterface {}

// integration_test_id:7c247981-f7ff-4720-a9fb-c8a7fbb06d4c
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

  test(
      'When the user leaves a non-member community, It should return error (400300: User [xxx] is not join this community [xxx]).',
      () async {
    when(() => mockCommunityMemberApiInterface.leaveCommunity(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_community_leave_fail.json').readAsString();
      throw AmityErrorResponse.fromJson(json.decode(response)).amityException();
    });

    try {
      await AmitySocialClient.newCommunityRepository().leaveCommunity(communityId);
    } catch (error) {
      expect(error, isA<AmityException>());
    }
  });
}
