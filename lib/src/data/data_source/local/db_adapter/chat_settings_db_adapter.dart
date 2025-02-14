import 'package:amity_sdk/src/data/data_source/local/hive_entity/chat_settings_hive_entity.dart';

abstract class ChatSettingsDbAdapter {
  Future deleteAllSettings();
  Future saveSettings(ChatSettingsHiveEntity entity);
  ChatSettingsHiveEntity? getSettings();
  Stream<ChatSettingsHiveEntity> observeSettings();
}
