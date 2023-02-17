import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockUserApiInterface extends Mock implements UserApiInterface {}

// integration_test_id:fddf1d63-98e2-4296-ab3a-4e2b55044f89
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  String userId = 'victimAndroid';

  final userApiInterface = MockUserApiInterface();

  setUpAll(() async {
    await AmityCoreClientMockSetup.setup();
    await AmityCoreClientMockSetup.loadMockSession();

    serviceLocator.registerLazySingleton<UserApiInterface>(
      () => userApiInterface,
    );
  });

  test('When the user try to unflag user, it should return success', () async {
    when(() => userApiInterface.unflag(any())).thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_user_unflag.json').readAsString();
      return UsersResponse.fromJson(json.decode(response));
    });

    final amityUser =
        await AmityCoreClient.newUserRepository().report(userId).unflag();

    expect(amityUser, isA<AmityUser>());
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
