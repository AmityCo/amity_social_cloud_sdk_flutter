import 'package:amity_sdk/src/core/model/api_request/validate_texts_request.dart';
import 'package:amity_sdk/src/core/model/api_request/validate_urls_request.dart';
import 'package:amity_sdk/src/data/response/chat_settings_response.dart';
import 'package:amity_sdk/src/data/response/text_url_validate_response.dart';
import 'package:amity_sdk/src/src.dart';
import 'package:dio/dio.dart';

class NetworkSettingsApiInterfaceImpl extends NetworkSettingsApiInterface{

  /// Http Api Client
  final HttpApiClient httpApiClient;

  NetworkSettingsApiInterfaceImpl({required this.httpApiClient});

  @override
  Future<bool> validateTexts(ValidateTextsRequest request) async  {
    try {
      final data = await httpApiClient()
          .post(VALIDATE_TEXT, data: request.toJson());
      return TextUrlValidationResponse.fromJson(data.data).success;
    } on DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<bool> validateUrls(ValidateUrlsRequest request) async {
    try {
      final data = await httpApiClient()
          .post(VALIDATE_URL , data: request.toJson());
      return TextUrlValidationResponse.fromJson(data.data).success;
    } on DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<ChatSettingsResponse> getChatSettings() async {
    try {
      final data = await httpApiClient().get(CHAT_SETTINGS);
      return ChatSettingsResponse.fromJson(data.data);
    } on DioException catch (error) {
      final response = error.response;
      if (response != null) {
        final amityError = AmityErrorResponse.fromJson(response.data);
        return Future.error(amityError.amityException());
      } else {
        return Future.error(error.toAmityExcetion());
      }
    } catch (error) {
      rethrow;
    }
  }

}