import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockUserApiInterface extends Mock implements UserApiInterface {}

// integration_test_id:5ac964db-43c9-459f-8bcf-2fd034a62907
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final userApiInterface = MockUserApiInterface();

  setUpAll(() async {
    registerFallbackValue(UsersRequest());

    await AmityCoreClientMockSetup.setup();
    await AmityCoreClientMockSetup.loadMockSession();

    serviceLocator.registerLazySingleton<UserApiInterface>(
      () => userApiInterface,
    );
  });

  test('- When user queries for list of blocked users, it should return list of blocked users', () async {
    when(() => userApiInterface.getBlockedUsers()).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_user_get_blocked_user.json').readAsString();
      return UsersResponse.fromJson(json.decode(response));
    });

    final amityUsers = await AmityCoreClient.newUserRepository().getBlockedUsers().query();

    expect(amityUsers, isList);
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
