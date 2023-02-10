import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockUserApiInterface extends Mock implements UserApiInterface {}

// integration_test_id:a95a0784-56ce-4b17-ac1b-0f1c50a361ef
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

  test('When the user try to unflag invalid user, it should return exception',
      () async {
    when(() => userApiInterface.unflag(any())).thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_user_unflag_400400.json')
              .readAsString();
      final amityError = AmityErrorResponse.fromJson(json.decode(response));
      throw amityError.amityException();
    });

    try {
      await AmityCoreClient.newUserRepository().report(userId).unflag();
    } catch (error) {
      expect(error, isA<AmityException>());
    }
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
