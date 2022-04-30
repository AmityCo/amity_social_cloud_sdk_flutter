import '../../core/model/api_request/register_notification_request.dart';
import '../../core/model/api_request/unregister_notification_request.dart';

abstract class NotificationRepo {
  Future registerNotification(RegisterNotificationRequest request);
  Future unregisterNotification(UnregisterNotificationRequest request);
}
