import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockUserApiInterface extends Mock implements UserApiInterface {}

// integration_test_id:f9133599-0aa5-438d-bd69-7231ca64232a
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
    registerFallbackValue(OptionsRequest());
  });

  test('When user queries for list of blocked users when none of them are blocked, it should return empty list',
      () async {
    when(() => userApiInterface.getBlockedUsers(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_user_get_blocked_user_empty.json').readAsString();
      return UsersResponse.fromJson(json.decode(response));
    });

    final amityUsers = await AmityCoreClient.newUserRepository().getBlockedUsers().query();

    expect(amityUsers, isList);
    expect(amityUsers, isEmpty);
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
