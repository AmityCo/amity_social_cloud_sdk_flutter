import 'package:amity_sdk/src/core/model/api_request/register_notification_request.dart';
import 'package:amity_sdk/src/core/model/api_request/unregister_notification_request.dart';

abstract class NotificationApiInterface {
  Future registerNotification(RegisterNotificationRequest request);
  Future unregisterNotification(UnregisterNotificationRequest request);
}
