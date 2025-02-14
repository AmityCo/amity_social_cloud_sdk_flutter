import 'package:amity_sdk/src/core/model/api_request/validate_texts_request.dart';
import 'package:amity_sdk/src/core/model/api_request/validate_urls_request.dart';
import 'package:amity_sdk/src/data/converter/chat_settings/chat_settings_hive_entity_converter_extension.dart';
import 'package:amity_sdk/src/data/converter/chat_settings/chat_settings_response_extension.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/chat_settings_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/remote/api_interface/network_settings_api_interface.dart';
import 'package:amity_sdk/src/domain/model/amity_chat_settings.dart';
import 'package:amity_sdk/src/domain/repo/network_settings_repo.dart';

class NetworkSettingsRepoImpl extends NetworkSettingsRepo {

  final NetworkSettingsApiInterface networkSettingsApiInterface;
  final ChatSettingsDbAdapter chatSettingsDbAdapter;

  NetworkSettingsRepoImpl({required this.networkSettingsApiInterface, required this.chatSettingsDbAdapter});

  @override
  Future<bool> validateTexts(ValidateTextsRequest request) async {
    return networkSettingsApiInterface.validateTexts(request);
  }

  @override
  Future<bool> validateUrls(ValidateUrlsRequest request) async {
    return networkSettingsApiInterface.validateUrls(request);
  }

  @override
  Future<AmityChatSettings> fetchChatSettings() async {
    final chatSettings = await networkSettingsApiInterface.getChatSettings();
    final entity = chatSettings.toHiveEntity();
    await chatSettingsDbAdapter.saveSettings(entity);
    return entity.convertToAmityChatSettings();
  }

  @override
  Future<AmityChatSettings> getChatSettings() async {
    final entity = chatSettingsDbAdapter.getSettings();
    if (entity == null) {
      return fetchChatSettings();
    } else {
      return entity.convertToAmityChatSettings();
    }
  }

  @override
  Stream<AmityChatSettings> observeChatSettings() {
    return chatSettingsDbAdapter.observeSettings().map((event) => event.convertToAmityChatSettings());
  }

  @override
  Future deleteChatSettings() async {
    return await chatSettingsDbAdapter.deleteAllSettings();
  }
}