import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockAnalyticsApiInterface extends Mock implements AnalyticsApiInterface {}

// integration_test_id:74889fc6-a82d-483e-b365-72fb15e6fd81
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final mockAnalyticsApiInterface = MockAnalyticsApiInterface();

  setUpAll(() async {
    registerFallbackValue(GetReachUserRequest());

    await AmityCoreClientMockSetup.setup();

    await AmityCoreClientMockSetup.loadMockSession();

    serviceLocator.registerLazySingleton<AnalyticsApiInterface>(
      () => mockAnalyticsApiInterface,
    );
  });

  test(
      'When the user try to query viewed user for a post, it should return AmityUsers',
      () async {
    when(() => mockAnalyticsApiInterface
        .queryPostReachUsers(any<GetReachUserRequest>())).thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_user_get_users.json').readAsString();
      return UsersResponse.fromJson(json.decode(response));
    });

    final amityUsersPage = await AmityCoreClient.newUserRepository()
        .getViewedUsers(viewedType: AmityViewedType.POST, viewedId: 'postId')
        .getPagingData(token: '', limit: 10);
    final amityUsers = amityUsersPage.data;

    expect(amityUsers, isList);
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
