import 'package:amity_sdk/src/core/model/api_request/validate_texts_request.dart';
import 'package:amity_sdk/src/core/model/api_request/validate_urls_request.dart';
import 'package:amity_sdk/src/domain/model/amity_chat_settings.dart';

abstract class NetworkSettingsRepo {
  Future<bool> validateUrls(ValidateUrlsRequest request);
  Future<bool> validateTexts(ValidateTextsRequest request);
  Future<AmityChatSettings> fetchChatSettings();
  Future<AmityChatSettings> getChatSettings();
  Stream<AmityChatSettings> observeChatSettings();
  Future deleteChatSettings();
}