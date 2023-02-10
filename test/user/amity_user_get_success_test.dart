import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockUserApiInterface extends Mock implements UserApiInterface {}

// integration_test_id:c9d28b37-c761-4df5-ac86-060a506f3007
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  String userId = 'victimAndroid';
  String displayName = 'Victim Android';

  final userApiInterface = MockUserApiInterface();

  setUpAll(() async {
    await AmityCoreClientMockSetup.setup();
    await AmityCoreClientMockSetup.loadMockSession();

    serviceLocator.registerLazySingleton<UserApiInterface>(
      () => userApiInterface,
    );
  });

  test('When the user get valid user with userId, it should return success',
      () async {
    when(() => userApiInterface.getUserById(any())).thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_user_get.json').readAsString();
      return UsersResponse.fromJson(json.decode(response));
    });

    final amityUser = await AmityCoreClient.newUserRepository().getUser(userId);

    expect(amityUser, isA<AmityUser>());
    expect(amityUser.userId, userId);
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
