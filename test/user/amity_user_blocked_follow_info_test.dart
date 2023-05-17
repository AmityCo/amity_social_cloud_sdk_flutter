import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockFollowApiInterface extends Mock implements FollowApiInterface {}

// integration_test_id:09d150b5-350e-46de-8c0d-548b497ee01c
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  String userId = 'victimAndroid';

  final followApiInterface = MockFollowApiInterface();

  setUpAll(() async {
    await AmityCoreClientMockSetup.setup();
    await AmityCoreClientMockSetup.loadMockSession();

    serviceLocator.registerLazySingleton<FollowApiInterface>(
      () => followApiInterface,
    );
  });

  test('When user queries follow info of blocked user, its follow status should be changed to blocked', () async {
    when(() => followApiInterface.getFollowInfo(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_user_blocked_follow_info.json').readAsString();
      return FollowInfoResponse.fromJson(json.decode(response));
    });

    final amityUserFollowInfo = await AmityCoreClient.newUserRepository().relationship().getFollowInfo(userId);

    expect(amityUserFollowInfo, isA<AmityUserFollowInfo>());
    expect(amityUserFollowInfo.status, AmityFollowStatus.BLOCKED);
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
