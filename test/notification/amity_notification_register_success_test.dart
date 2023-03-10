import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uuid/uuid.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockNotificationApiInterface extends Mock
    implements NotificationApiInterface {}

// integration_test_id:929e18eb-ac7b-461e-91b3-f41b276a2b64
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  String userId = 'victimAndroid';
  String deviceId = const Uuid().v1();
  String platform = 'android';
  String provider = 'fcm';
  String token = const Uuid().v1();

  final notificationApiInterface = MockNotificationApiInterface();

  setUpAll(() async {
    registerFallbackValue(RegisterNotificationRequest(
      userId: userId,
      deviceId: deviceId,
      platform: platform,
      provider: provider,
      token: token,
    ));

    await AmityCoreClientMockSetup.setup();
    await AmityCoreClientMockSetup.loadMockSession();

    serviceLocator.registerLazySingleton<NotificationApiInterface>(
      () => notificationApiInterface,
    );
  });

  test(
      'When the user registers push notification, it should return a successful result. ',
      () async {
    when(() => notificationApiInterface.registerNotification(
        any<RegisterNotificationRequest>())).thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_notification_register_success.json')
              .readAsString();
      return true;
    });

    final response = await AmityCoreClient.registerDeviceNotification(token);

    expect(response, isA<bool>());
    expect(response, isTrue);
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
