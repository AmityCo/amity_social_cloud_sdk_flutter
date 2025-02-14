import 'package:amity_sdk/src/core/model/api_request/validate_texts_request.dart';
import 'package:amity_sdk/src/core/model/api_request/validate_urls_request.dart';
import 'package:amity_sdk/src/data/response/chat_settings_response.dart';

abstract class NetworkSettingsApiInterface{
  
  Future<bool> validateUrls(ValidateUrlsRequest request);
  Future<bool> validateTexts(ValidateTextsRequest request);
  
  Future<ChatSettingsResponse> getChatSettings();

}