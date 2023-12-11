import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/public/amity_core_client.dart';
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
    } on dio.DioException catch (error) {
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
    } on dio.DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
}
