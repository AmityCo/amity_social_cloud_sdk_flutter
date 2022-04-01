import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/core/model/api_request/unregister_notification_request.dart';
import 'package:amity_sdk/core/model/api_request/register_notification_request.dart';
import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/data/data_source/remote/api_interface/notification_api_interface.dart';
import 'package:amity_sdk/public/amity_core_client.dart';
import 'package:dio/dio.dart' as dio;

class NotificationApiInterfaceImpl extends NotificationApiInterface {
  NotificationApiInterfaceImpl(
      {required this.httpApiClient, required this.amityCoreClientOption});
  final HttpApiClient httpApiClient;
  final AmityCoreClientOption amityCoreClientOption;

  @override
  Future registerNotification(RegisterNotificationRequest request) {
    try {
      return httpApiClient().post(REGISTER_NOTIFICATION_V1_URL,
          data: request.toJson(),
          options: dio.Options(
              headers: {'X-API-Key': amityCoreClientOption.apiKey}));
    } on dio.DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future unregisterNotification(UnregisterNotificationRequest request) {
    try {
      return httpApiClient().delete(UNREGISTER_NOTIFICATION_V1_URL,
          data: request.toJson(),
          options: dio.Options(
              headers: {'X-API-Key': amityCoreClientOption.apiKey}));
    } on dio.DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
}
