import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockUserApiInterface extends Mock implements UserApiInterface {}

// integration_test_id:60b4b354-efca-49bc-aa8b-d63a8da6ef31
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

  test(
      'When the user try to search user by keyword, it should return success and AmityUser array',
      () async {
    when(() => userApiInterface.getUsers(any())).thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_user_search_by_display_name.json')
              .readAsString();
      return UsersResponse.fromJson(json.decode(response));
    });

    final amityUsers =
        await AmityCoreClient.newUserRepository().getUsers().query();

    expect(amityUsers, isList);
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
