import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/core/model/api_request/unregister_notification_request.dart';
import 'package:amity_sdk/core/model/api_request/register_notification_request.dart';
import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/data/data_source/remote/api_interface/notification_api_interface.dart';
import 'package:dio/dio.dart';

class NotificationApiInterfaceImpl extends NotificationApiInterface {
  NotificationApiInterfaceImpl({required this.httpApiClient});
  final HttpApiClient httpApiClient;

  @override
  Future registerNotification(RegisterNotificationRequest request) {
    try {
      return httpApiClient()
          .get(REGISTER_NOTIFICATION_V1_URL, queryParameters: request.toJson());
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future unregisterNotification(UnregisterNotificationRequest request) {
    try {
      return httpApiClient().get(UNREGISTER_NOTIFICATION_V1_URL,
          queryParameters: request.toJson());
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
}
