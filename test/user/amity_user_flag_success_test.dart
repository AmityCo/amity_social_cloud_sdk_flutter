import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockUserApiInterface extends Mock implements UserApiInterface {}

// integration_test_id:ca4a760f-4342-4a99-9f3c-6c17cd205ca6
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

  test('When the user try to flag user, it should return success', () async {
    when(() => userApiInterface.flag(any())).thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_user_flag.json').readAsString();
      return UsersResponse.fromJson(json.decode(response));
    });

    final amityUser =
        await AmityCoreClient.newUserRepository().report(userId).flag();

    expect(amityUser, isA<AmityUser>());
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
