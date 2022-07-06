import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// Notification Repository for notification related operation
class NotificationRepository {
  /// Register Firebase device token mapped with mapped device id
  Future registerDeviceNotification(String fcmToken) {
    return serviceLocator<RegisterDeviceNotificationUseCase>().get(fcmToken);
  }

  /// Unlink the Firebase device token with mapped device id
  Future unregisterDeviceNotification() {
    return serviceLocator<UnregisterDeviceNotificationUseCase>().get(null);
  }
}
